package com.foxconn.fii.security.config;

import org.springframework.security.oauth2.client.filter.OAuth2ClientContextFilter;
import org.springframework.security.oauth2.client.resource.UserRedirectRequiredException;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.web.util.UriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;

public class CustomOAuth2ClientContextFilter extends OAuth2ClientContextFilter {

    private String[] domains;

    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    public CustomOAuth2ClientContextFilter(String[] domains) {
        this.domains = domains;
    }

    @Override
    protected void redirectUser(UserRedirectRequiredException e, HttpServletRequest request, HttpServletResponse response) throws IOException {
        String requestUrl = request.getRequestURL().toString();
        boolean trustFlag = false;
        for (String domain : this.domains) {
            if (requestUrl.startsWith(domain)) {
                trustFlag = true;
                break;
            }
        }

        String redirectUri = e.getRedirectUri();
        if (!trustFlag) {
            redirectUri = requestUrl.substring(0, requestUrl.indexOf("/", 10)) + redirectUri.substring(redirectUri.indexOf("/", 10));
        }

        UriComponentsBuilder builder = UriComponentsBuilder
                .fromHttpUrl(redirectUri);
        Map<String, String> requestParams = e.getRequestParams();
        for (Map.Entry<String, String> param : requestParams.entrySet()) {
            builder.queryParam(param.getKey(), param.getValue());
        }

        if (e.getStateKey() != null) {
            builder.queryParam("state", e.getStateKey());
        }

        this.redirectStrategy.sendRedirect(request, response, builder.build()
                .encode().toUriString());
    }
}
