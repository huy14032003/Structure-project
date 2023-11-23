package com.foxconn.fii.security.service.impl;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.foxconn.fii.common.exception.CommonException;
import com.foxconn.fii.common.response.CommonResponse;
import com.foxconn.fii.security.config.OAuth2Principal;
import com.foxconn.fii.security.config.OAuth2Properties;
import com.foxconn.fii.security.jwt.model.token.JwtAuthenticationToken;
import com.foxconn.fii.security.jwt.model.token.RawToken;
import com.foxconn.fii.security.model.JwtTokenResponse;
import com.foxconn.fii.security.model.OAuth2User;
import com.foxconn.fii.security.model.UserContext;
import com.foxconn.fii.security.service.OAuth2Service;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.*;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestClientException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.Base64;
import java.util.Map;

import static com.foxconn.fii.security.jwt.config.JwtProperties.*;

@Slf4j
@Service
public class OAuth2ServiceImpl implements OAuth2Service {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private OAuth2Properties oauth2Properties;

    @Autowired
    private ObjectMapper objectMapper;

    @Override
    public UserContext getUserInformation(String username) {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
        String authorization = Base64.getEncoder().encodeToString(
                String.format("%s:%s", oauth2Properties.getClient().getClientId(), oauth2Properties.getClient().getClientSecret()).getBytes());
        headers.add(AUTHENTICATION_HEADER_NAME, BASIC_TOKEN_PREFIX + authorization);

        MultiValueMap<String, String> map = new LinkedMultiValueMap<>();
        map.add("username", username);

        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(map, headers);

        ResponseEntity<CommonResponse<UserContext>> responseEntity;
        try {
            responseEntity = restTemplate.exchange(oauth2Properties.getResource().getNormalUserInfoUri(), HttpMethod.POST, entity, new ParameterizedTypeReference<CommonResponse<UserContext>>() {});
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
                String username = (String) principal.getPrincipal();

                OAuth2User oauth2User = getCurrentUserInformation();

//                OAuth2AuthenticationDetails details = (OAuth2AuthenticationDetails) authentication.getDetails();
//                user.setSessionId(details.getSessionId());

                SecurityContextHolder.getContext().setAuthentication(new OAuth2Principal(principal, oauth2User));

                return oauth2User;
            }
        } else if (authentication instanceof JwtAuthenticationToken) {
            JwtAuthenticationToken principal = (JwtAuthenticationToken) authentication;
            if (principal.getPrincipal() != null) {
                String username = ((UserContext) principal.getPrincipal()).getUsername();

                OAuth2User oauth2User = getCurrentUserInformation();

//                user.setSessionId(((RawToken) principal.getCredentials()).getToken());

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
    public JwtTokenResponse getToken(String username, String password, String mfaType, String mfaValue, String uuid) {
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

        ResponseEntity<JwtTokenResponse> responseEntity;
        try {
            responseEntity = restTemplate.exchange(oauth2Properties.getClient().getAccessTokenUri(), HttpMethod.POST, entity, new ParameterizedTypeReference<JwtTokenResponse>() {});
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
    public OAuth2User getCurrentUserInformation() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String token = "";
        if (authentication instanceof JwtAuthenticationToken) {
            JwtAuthenticationToken principal = (JwtAuthenticationToken) authentication;
            token = ((RawToken) principal.getCredentials()).getToken();
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
            token = ((RawToken) principal.getCredentials()).getToken();
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
