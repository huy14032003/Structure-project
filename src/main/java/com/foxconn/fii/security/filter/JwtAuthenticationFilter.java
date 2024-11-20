package com.foxconn.fii.security.filter;

import com.foxconn.fii.common.utils.CookieUtils;
import com.foxconn.fii.security.config.PathRequestMatcher;
import com.foxconn.fii.security.exception.JwtTokenInvalidException;
import com.foxconn.fii.security.model.JwtAuthenticationToken;
import com.foxconn.fii.security.model.UserContext;
import com.foxconn.fii.security.service.OAuth2Service;
import com.foxconn.fii.security.utils.JwtTokenUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.AbstractAuthenticationProcessingFilter;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.util.matcher.RequestMatcher;
import org.springframework.util.StringUtils;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Collections;

import static com.foxconn.fii.security.config.JwtProperties.AUTHENTICATION_HEADER_NAME;

public class JwtAuthenticationFilter extends AbstractAuthenticationProcessingFilter {

    private final RequestMatcher endpointMatcher;

    private final AuthenticationFailureHandler failureHandler;

    private final OAuth2Service oAuth2Service;

    public JwtAuthenticationFilter(RequestMatcher matcher, AuthenticationFailureHandler failureHandler, OAuth2Service oAuth2Service) {
        super(matcher);
        this.failureHandler = failureHandler;
        this.oAuth2Service = oAuth2Service;

        String[] securedEndpointList = {"/api/**"};
        this.endpointMatcher = new PathRequestMatcher(securedEndpointList);
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {

        if (SecurityContextHolder.getContext().getAuthentication() != null &&
                SecurityContextHolder.getContext().getAuthentication().isAuthenticated()) {
            return SecurityContextHolder.getContext().getAuthentication();
        }

        /* get token from cookies */
        String accessToken = CookieUtils.getCookieValue(request, "access_token");
        String refreshToken = CookieUtils.getCookieValue(request, "refresh_token");

        /* get token from authentication header */
        if (StringUtils.isEmpty(accessToken)) {
            String authenticationHeader = request.getHeader(AUTHENTICATION_HEADER_NAME);
            if (!StringUtils.isEmpty(authenticationHeader)) {
                accessToken = JwtTokenUtils.extractJwtTokenHeader(authenticationHeader);
            }
        }

        try {
            UserContext userContext = oAuth2Service.getUserDetails(accessToken, refreshToken);

            JwtAuthenticationToken authentication = new JwtAuthenticationToken(accessToken, userContext.getUsername(), userContext.getAuthorities());
            authentication.setDetails(this.authenticationDetailsSource.buildDetails(request));
            return authentication;
        } catch (Exception e) {
            return buildAnonymousAuthentication(request);
        }
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


    private Authentication buildAnonymousAuthentication(HttpServletRequest request) {
        if (endpointMatcher.matches(request)) {
            throw new JwtTokenInvalidException("Invalid JWT access token");
        }

        SecurityContextHolder.clearContext();
        return new JwtAuthenticationToken("anonymousUser", Collections.emptyList());
    }
}
