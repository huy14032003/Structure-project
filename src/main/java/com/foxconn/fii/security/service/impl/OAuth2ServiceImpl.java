package com.foxconn.fii.security.service.impl;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.foxconn.fii.common.exception.CommonException;
import com.foxconn.fii.common.response.CommonResponse;
import com.foxconn.fii.security.config.JwksProperties;
import com.foxconn.fii.security.config.OAuth2Properties;
import com.foxconn.fii.security.exception.JwtTokenInvalidException;
import com.foxconn.fii.security.model.*;
import com.foxconn.fii.security.service.OAuth2Service;
import com.foxconn.fii.security.utils.JwtTokenUtils;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.StringUtils;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.foxconn.fii.security.config.JwtProperties.*;

@Slf4j
@Service
public class OAuth2ServiceImpl implements OAuth2Service {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private OAuth2Properties oauth2Properties;

    @Autowired
    private JwksProperties jwksProperties;

    @Autowired
    private ObjectMapper objectMapper;


    @Override
    public JwtTokenWrapper getClientCredentialsToken() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        String authorization = Base64.getEncoder().encodeToString(
                String.format("%s:%s", oauth2Properties.getClient().getClientId(), oauth2Properties.getClient().getClientSecret()).getBytes());
        headers.add(AUTHENTICATION_HEADER_NAME, BASIC_TOKEN_PREFIX + authorization);

        MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
        map.add("grant_type", "client_credentials");

        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(map, headers);

        ResponseEntity<JwtTokenWrapper> responseEntity;
        try {
            responseEntity = restTemplate.exchange(oauth2Properties.getClient().getAccessTokenUri(), HttpMethod.POST, entity, new ParameterizedTypeReference<JwtTokenWrapper>() {});
        } catch (RestClientException e) {
            log.error("### get token error", e);
            try {
                HttpClientErrorException httpException = (HttpClientErrorException) e;
                Map<String, Object> responseBody = objectMapper.readValue(httpException.getResponseBodyAsString(), new TypeReference<Map<String, Object>>() {
                });
                throw new CommonException((String) responseBody.getOrDefault("error_description", responseBody.getOrDefault("message", "Username or password invalid")));
            } catch (CommonException ce) {
                throw ce;
            } catch (Exception ce) {
                throw new CommonException("Username or password invalid");
            }
        }

        if (!responseEntity.getStatusCode().is2xxSuccessful() || responseEntity.getBody() == null) {
            throw new CommonException("Username or password invalid");
        }

        return responseEntity.getBody();
    }

    @Override
    public JwtTokenWrapper getAccessToken(String username, String password, String mfaType, String mfaValue, String uuid) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        String authorization = Base64.getEncoder().encodeToString(
                String.format("%s:%s", oauth2Properties.getClient().getClientId(), oauth2Properties.getClient().getClientSecret()).getBytes());
        headers.add(AUTHENTICATION_HEADER_NAME, BASIC_TOKEN_PREFIX + authorization);

        MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
        map.add("username", username);
        map.add("password", password);
        map.add("grant_type", "password");
        map.add("mfa_type", mfaType);
        map.add("mfa_value", mfaValue);
        map.add("mac", uuid);

        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(map, headers);

        ResponseEntity<JwtTokenWrapper> responseEntity;
        try {
            responseEntity = restTemplate.exchange(oauth2Properties.getClient().getAccessTokenUri(), HttpMethod.POST, entity, new ParameterizedTypeReference<JwtTokenWrapper>() {});
        } catch (RestClientException e) {
            log.error("### get token error", e);
            try {
                HttpClientErrorException httpException = (HttpClientErrorException) e;
                Map<String, Object> responseBody = objectMapper.readValue(httpException.getResponseBodyAsString(), new TypeReference<Map<String, Object>>() {
                });
                throw new CommonException((String) responseBody.getOrDefault("error_description", responseBody.getOrDefault("message", "Username or password invalid")));
            } catch (CommonException ce) {
                throw ce;
            } catch (Exception ce) {
                throw new CommonException("Username or password invalid");
            }
        }

        if (!responseEntity.getStatusCode().is2xxSuccessful() || responseEntity.getBody() == null) {
            throw new CommonException("Username or password invalid");
        }

        return responseEntity.getBody();
    }


    @Override
    public JwtTokenWrapper getAccessToken(String refreshToken) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        String authorization = Base64.getEncoder().encodeToString(
                String.format("%s:%s", oauth2Properties.getClient().getClientId(), oauth2Properties.getClient().getClientSecret()).getBytes());
        headers.add(AUTHENTICATION_HEADER_NAME, BASIC_TOKEN_PREFIX + authorization);

        MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
        map.add("refresh_token", refreshToken);
        map.add("grant_type", "refresh_token");

        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(map, headers);

        ResponseEntity<JwtTokenWrapper> responseEntity;
        try {
            responseEntity = restTemplate.exchange(oauth2Properties.getClient().getAccessTokenUri(), HttpMethod.POST, entity, new ParameterizedTypeReference<JwtTokenWrapper>() {});
        } catch (RestClientException e) {
            log.error("### get token error", e);
            try {
                HttpClientErrorException httpException = (HttpClientErrorException) e;
                Map<String, Object> responseBody = objectMapper.readValue(httpException.getResponseBodyAsString(), new TypeReference<Map<String, Object>>() {});
                throw new CommonException((String) responseBody.getOrDefault("error_description", responseBody.getOrDefault("message", "Username or password invalid")));
            } catch (CommonException ce) {
                throw ce;
            } catch (Exception ce) {
                throw new CommonException("Invalid JWT token");
            }
        }

        if (!responseEntity.getStatusCode().is2xxSuccessful() || responseEntity.getBody() == null) {
            throw new JwtTokenInvalidException("Invalid JWT token");
        }

        return responseEntity.getBody();
    }

    @SuppressWarnings("unchecked")
    @Override
    public UserContext getUserDetails(String accessToken, String refreshToken) {
        if (StringUtils.isEmpty(accessToken) && StringUtils.isEmpty(refreshToken)) {
            throw new JwtTokenInvalidException("Invalid JWT token");
        }

        Jws<Claims> claims;
        try {
            claims = JwtTokenUtils.parseClaims(accessToken, jwksProperties.getKeys().get(0).getPublicKey());
        } catch (Exception e) {
            try {
                JwtTokenWrapper jwtToken = getAccessToken(refreshToken);
                claims = JwtTokenUtils.parseClaims(jwtToken.getAccessToken(), jwksProperties.getKeys().get(0).getPublicKey());
            } catch (Exception ce) {
                throw new JwtTokenInvalidException("Invalid JWT token");
            }
        }

        String username = (String) claims.getBody().get("user_name");
        Object rawAuthorities = claims.getBody().get("authorities");

        if (!(rawAuthorities instanceof List)) {
            throw new JwtTokenInvalidException("Invalid JWT token");
        }
        List<GrantedAuthority> authorities = ((List<String>) rawAuthorities).stream().map(SimpleGrantedAuthority::new).collect(Collectors.toList());

        UserContext userContext = new UserContext();
        userContext.setUsername(username);
        userContext.setAuthorities(authorities);

        return userContext;
    }

    @Override
    public UserContext getUserDetails(String username) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        String clientCredentialsToken = getClientCredentialsToken().getAccessToken();
        headers.add(AUTHENTICATION_HEADER_NAME, BEARER_TOKEN_PREFIX + clientCredentialsToken);

        HttpEntity<Object> entity = new HttpEntity<>(headers);

        ResponseEntity<CommonResponse<UserContext>> responseEntity;
        try {
            UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder
                    .fromHttpUrl(oauth2Properties.getResource().getUserDetailsUri())
                    .queryParam("username", username);
            responseEntity = restTemplate.exchange(uriComponentsBuilder.toUriString(), HttpMethod.GET, entity, new ParameterizedTypeReference<CommonResponse<UserContext>>() {});
        } catch (RestClientException e) {
            log.error("### get token error", e);
            try {
                HttpClientErrorException httpException = (HttpClientErrorException) e;
                Map<String, Object> responseBody = objectMapper.readValue(httpException.getResponseBodyAsString(), new TypeReference<Map<String, Object>>() {
                });
                throw new CommonException((String) responseBody.getOrDefault("error_description", responseBody.getOrDefault("message", "Username or password invalid")));
            } catch (CommonException ce) {
                throw ce;
            } catch (Exception ce) {
                throw new CommonException("Username or password invalid");
            }
        }

        if (!responseEntity.getStatusCode().is2xxSuccessful() || responseEntity.getBody() == null) {
            throw new CommonException("Username or password invalid");
        }

        return responseEntity.getBody().getResult();
    }

    @Override
    public OAuth2User searchUserInformation(String username) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        String clientCredentialsToken = getClientCredentialsToken().getAccessToken();
        headers.add(AUTHENTICATION_HEADER_NAME, BEARER_TOKEN_PREFIX + clientCredentialsToken);

        HttpEntity<Object> entity = new HttpEntity<>(headers);

        ResponseEntity<CommonResponse<OAuth2User>> responseEntity;
        try {
            UriComponentsBuilder uriComponentsBuilder = UriComponentsBuilder
                    .fromHttpUrl(oauth2Properties.getResource().getUserSearchUri())
                    .queryParam("username", username);
            responseEntity = restTemplate.exchange(uriComponentsBuilder.toUriString(), HttpMethod.GET, entity, new ParameterizedTypeReference<CommonResponse<OAuth2User>>() {});
        } catch (RestClientException e) {
            log.error("### get token error", e);
            try {
                HttpClientErrorException httpException = (HttpClientErrorException) e;
                Map<String, Object> responseBody = objectMapper.readValue(httpException.getResponseBodyAsString(), new TypeReference<Map<String, Object>>() {
                });
                throw new CommonException((String) responseBody.getOrDefault("error_description", responseBody.getOrDefault("message", "Username or password invalid")));
            } catch (CommonException ce) {
                throw ce;
            } catch (Exception ce) {
                throw new CommonException("Username or password invalid");
            }
        }

        if (!responseEntity.getStatusCode().is2xxSuccessful() || responseEntity.getBody() == null) {
            throw new CommonException("Username or password invalid");
        }

        return responseEntity.getBody().getResult();
    }

    @Override
    public OAuth2User getCurrentUser() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication instanceof OAuth2Principal) {
            OAuth2Principal principal = (OAuth2Principal) authentication;
            return principal.getUser();
        } else if (authentication instanceof OAuth2Authentication) {
            OAuth2Authentication principal = (OAuth2Authentication) authentication;
            if (principal.getPrincipal() != null) {
//                OAuth2AuthenticationDetails details = (OAuth2AuthenticationDetails) authentication.getDetails();
//                user.setSessionId(details.getSessionId());
                String username = (String) principal.getPrincipal();

                OAuth2User oauth2User = getCurrentUserInformation();
                oauth2User.setUsername(username);
                SecurityContextHolder.getContext().setAuthentication(new OAuth2Principal(principal, oauth2User));

                return oauth2User;
            }
        } else if (authentication instanceof JwtAuthenticationToken) {
            JwtAuthenticationToken principal = (JwtAuthenticationToken) authentication;
            if (principal.getPrincipal() != null) {
//                String username = ((UserContext) principal.getPrincipal()).getUsername();
//                user.setSessionId(((RawToken) principal.getCredentials()).getToken());
                String username = (String) principal.getPrincipal();

                OAuth2User oauth2User = getCurrentUserInformation();
                oauth2User.setUsername(username);

                return oauth2User;
            }
        } else if (authentication instanceof UsernamePasswordAuthenticationToken) {
            UsernamePasswordAuthenticationToken principal = (UsernamePasswordAuthenticationToken) authentication;
            if (principal.getPrincipal() != null) {
                String username = (String) principal.getPrincipal();

                OAuth2User oauth2User = new OAuth2User();
                oauth2User.setUsername(username);

                return oauth2User;
            }
        }

        throw CommonException.of("Get current user not supported {}", authentication);
    }

    @Override
    public OAuth2User getCurrentUserInformation() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String token = "";
        if (authentication instanceof JwtAuthenticationToken) {
            JwtAuthenticationToken principal = (JwtAuthenticationToken) authentication;
            token = ((JwtTokenWrapper) principal.getCredentials()).getAccessToken();
        } else {
            OAuth2AuthenticationDetails details = (OAuth2AuthenticationDetails) authentication.getDetails();
            if (details != null) {
                token = details.getTokenValue();
            }
        }

        HttpHeaders headers = new HttpHeaders();
        headers.add(AUTHENTICATION_HEADER_NAME, BEARER_TOKEN_PREFIX + token);
        HttpEntity<String> entity = new HttpEntity<>("", headers);

        ResponseEntity<CommonResponse<OAuth2User>> responseEntity;
        try {
            responseEntity = restTemplate.exchange(oauth2Properties.getResource().getUserInfoUri(), HttpMethod.GET, entity, new ParameterizedTypeReference<CommonResponse<OAuth2User>>() {});
        } catch (RestClientException e) {
            log.error("### get current user error", e);
            try {
                HttpClientErrorException httpException = (HttpClientErrorException) e;
                Map<String, Object> responseBody = objectMapper.readValue(httpException.getResponseBodyAsString(), new TypeReference<Map<String, Object>>() {
                });
                throw new CommonException((String) responseBody.getOrDefault("error_description", responseBody.getOrDefault("message", "Invalid JWT access token")));
            } catch (CommonException ce) {
                throw ce;
            } catch (Exception ce) {
                throw new CommonException("Invalid JWT access token");
            }
        }

        if (!responseEntity.getStatusCode().is2xxSuccessful() || responseEntity.getBody() == null) {
            throw new CommonException("Invalid JWT access token");
        }

        return responseEntity.getBody().getResult();
    }

    @Override
    public void changePassword(String oldPassword, String newPassword) {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String token = "";
        if (authentication instanceof JwtAuthenticationToken) {
            JwtAuthenticationToken principal = (JwtAuthenticationToken) authentication;
            token = ((JwtTokenWrapper) principal.getCredentials()).getAccessToken();
        } else {
            OAuth2AuthenticationDetails details = (OAuth2AuthenticationDetails) authentication.getDetails();
            if (details != null) {
                token = details.getTokenValue();
            }
        }

        HttpHeaders headers = new HttpHeaders();
        headers.add(AUTHENTICATION_HEADER_NAME, BEARER_TOKEN_PREFIX + token);
        HttpEntity<String> entity = new HttpEntity<>("", headers);

        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(oauth2Properties.getResource().getUserChangePassUri())
                .queryParam("oldPassword", oldPassword)
                .queryParam("newPassword", newPassword);

        ResponseEntity<CommonResponse<Boolean>> responseEntity;
        try {
            responseEntity = restTemplate.exchange(uriBuilder.toUriString(), HttpMethod.POST, entity, new ParameterizedTypeReference<CommonResponse<Boolean>>() {});
        } catch (RestClientException e) {
            log.error("### change password error", e);
            try {
                HttpClientErrorException httpException = (HttpClientErrorException) e;
                Map<String, Object> responseBody = objectMapper.readValue(httpException.getResponseBodyAsString(), new TypeReference<Map<String, Object>>() {
                });
                throw new CommonException((String) responseBody.getOrDefault("error_description", responseBody.getOrDefault("message", "Invalid JWT access token")));
            } catch (CommonException ce) {
                throw ce;
            } catch (Exception ce) {
                throw new CommonException("Invalid JWT access token");
            }
        }

        if (!responseEntity.getStatusCode().is2xxSuccessful() || responseEntity.getBody() == null) {
            throw new CommonException("Invalid JWT access token");
        }
    }
}
