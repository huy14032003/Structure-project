package com.foxconn.fii.security.config;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.foxconn.fii.security.exception.JwtTokenInvalidException;
import com.foxconn.fii.security.jwt.config.PathRequestMatcher;
import com.foxconn.fii.security.jwt.model.token.JwtAuthenticationToken;
import com.foxconn.fii.security.jwt.model.token.extractor.TokenExtractor;
import com.foxconn.fii.security.model.UserContext;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Base64;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.foxconn.fii.security.jwt.config.JwtProperties.AUTHENTICATION_HEADER_NAME;
import static com.foxconn.fii.security.jwt.config.JwtProperties.BASIC_TOKEN_PREFIX;

public class JwtAuthenticationFilter extends AbstractAuthenticationProcessingFilter {

    private final AuthenticationFailureHandler failureHandler;

    private final RequestMatcher endpointMatcher;

    private final OAuth2Properties oauth2Properties;

    private final TokenExtractor tokenExtractor;

    private final RestTemplate restTemplate;

    private final ObjectMapper objectMapper;

    public JwtAuthenticationFilter(AuthenticationFailureHandler failureHandler, RequestMatcher matcher, OAuth2Properties oauth2Properties,
                                   TokenExtractor tokenExtractor, RestTemplate restTemplate, ObjectMapper objectMapper) {
        super(matcher);
        this.failureHandler = failureHandler;
        this.oauth2Properties = oauth2Properties;

        this.tokenExtractor = tokenExtractor;
        this.restTemplate = restTemplate;
        this.objectMapper = objectMapper;

        String[] securedEndpointList = {"/api/**"};
        this.endpointMatcher = new PathRequestMatcher(securedEndpointList);
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response)
            throws AuthenticationException, IOException, ServletException {

        if (SecurityContextHolder.getContext().getAuthentication() != null &&
                SecurityContextHolder.getContext().getAuthentication().isAuthenticated()) {
            return SecurityContextHolder.getContext().getAuthentication();
        }

        /* get token from cookies */
        String token = null;
        String refreshToken = null;
        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if ("access_token".equalsIgnoreCase(cookie.getName())) {
                    token = cookie.getValue();
                }
                if ("refresh_token".equalsIgnoreCase(cookie.getName())) {
                    refreshToken = cookie.getValue();
                }
            }
        }

        /* get token from header */
        if (StringUtils.isEmpty(token)) {
            token = request.getHeader(AUTHENTICATION_HEADER_NAME);
            if (!StringUtils.isEmpty(token)) {
                token = tokenExtractor.extract(token);
            }
        }

        if (StringUtils.isEmpty(token) && StringUtils.isEmpty(refreshToken)) {
            return buildAnonymousAuthentication(request);
        }

        if (StringUtils.isEmpty(token)) {
            try {
                token = getTokenFromRefreshToken(refreshToken, response);
            } catch (RestClientException e) {
                return buildAnonymousAuthentication(request);
            }
        }

        HttpHeaders headers = new HttpHeaders();
        String authorization = Base64.getEncoder().encodeToString(
                String.format("%s:%s", oauth2Properties.getClient().getClientId(), oauth2Properties.getClient().getClientSecret()).getBytes());
        headers.add(AUTHENTICATION_HEADER_NAME, BASIC_TOKEN_PREFIX + authorization);

        HttpEntity<String> entity = new HttpEntity<>("", headers);

        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(oauth2Properties.getResource().getTokenInfoUri()).queryParam("token", token);

        ResponseEntity<Map<String, Object>> responseEntity;
        try {
            responseEntity = restTemplate.exchange(uriBuilder.toUriString(), HttpMethod.POST, entity, new ParameterizedTypeReference<Map<String, Object>>() {});
        } catch (RestClientException e) {
            try {
                HttpClientErrorException httpException = (HttpClientErrorException) e;
                Map<String, Object> responseBody = objectMapper.readValue(httpException.getResponseBodyAsString(), new TypeReference<Map<String, Object>>() {
                });
                if (!((String) responseBody.getOrDefault("error_description", "")).startsWith("Token has expired")) {
                    return buildAnonymousAuthentication(request);
                }

                token = getTokenFromRefreshToken(refreshToken, response);

                uriBuilder = UriComponentsBuilder.fromHttpUrl(oauth2Properties.getResource().getTokenInfoUri()).queryParam("token", token);
                responseEntity = restTemplate.exchange(uriBuilder.toUriString(), HttpMethod.POST, entity, new ParameterizedTypeReference<Map<String, Object>>() {});

            } catch (Exception ce) {
                return buildAnonymousAuthentication(request);
            }
        }

        if (!responseEntity.getStatusCode().is2xxSuccessful() || responseEntity.getBody() == null) {
            return buildAnonymousAuthentication(request);
        }

        String username = (String) responseEntity.getBody().get("user_name");
        Object rawAuthorities = responseEntity.getBody().get("authorities");
        if (!(rawAuthorities instanceof List)) {
            return buildAnonymousAuthentication(request);
        }
        List<GrantedAuthority> authorities = ((List<String>) rawAuthorities).stream().map(SimpleGrantedAuthority::new).collect(Collectors.toList());

        JwtAuthenticationToken authentication = new JwtAuthenticationToken(token, username, authorities);
        authentication.setDetails(this.authenticationDetailsSource.buildDetails(request));
        return authentication;
    }

    private Authentication buildAnonymousAuthentication(HttpServletRequest request) {
        if (endpointMatcher.matches(request)) {
            throw new JwtTokenInvalidException("Invalid JWT access token");
        }

        SecurityContextHolder.clearContext();
        return new JwtAuthenticationToken("anonymousUser", Collections.emptyList());
    }

    private String getTokenFromRefreshToken(String refreshToken, HttpServletResponse response) {
        HttpHeaders headers = new HttpHeaders();
        String authorization = Base64.getEncoder().encodeToString(
                String.format("%s:%s", oauth2Properties.getClient().getClientId(), oauth2Properties.getClient().getClientSecret()).getBytes());
        headers.add(AUTHENTICATION_HEADER_NAME, BASIC_TOKEN_PREFIX + authorization);

        MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
        map.add("refresh_token", refreshToken);
        map.add("grant_type", "refresh_token");

        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(map, headers);

        ResponseEntity<Map<String, Object>> responseEntity = restTemplate.exchange(oauth2Properties.getClient().getAccessTokenUri(),
                HttpMethod.POST, entity, new ParameterizedTypeReference<Map<String, Object>>() {
                });

        if (!responseEntity.getStatusCode().is2xxSuccessful() || responseEntity.getBody() == null) {
            throw new JwtTokenInvalidException("Invalid JWT refresh token");
        }

        String token = (String) responseEntity.getBody().get("access_token");

        Cookie cookie = new Cookie("access_token", token);
        cookie.setPath("/hr-system/");
        cookie.setMaxAge(12*60*60);
        response.addCookie(cookie);

        return token;
    }

    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response,
                                            FilterChain chain, Authentication authResult) throws IOException, ServletException {
        if (SecurityContextHolder.getContext().getAuthentication() == null && !"anonymousUser".equals(authResult.getPrincipal())) {
            SecurityContext context = SecurityContextHolder.createEmptyContext();
            context.setAuthentication(authResult);
            SecurityContextHolder.setContext(context);
        }
        chain.doFilter(request, response);
    }

    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response,
                                              AuthenticationException failed) throws IOException, ServletException {
        SecurityContextHolder.clearContext();
        failureHandler.onAuthenticationFailure(request, response, failed);
    }
}
