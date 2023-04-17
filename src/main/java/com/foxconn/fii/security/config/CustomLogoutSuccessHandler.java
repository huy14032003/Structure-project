package com.foxconn.fii.security.config;

import com.foxconn.fii.common.utils.CookieUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AbstractAuthenticationTargetUrlRequestHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.util.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CustomLogoutSuccessHandler extends AbstractAuthenticationTargetUrlRequestHandler implements LogoutSuccessHandler {

    private String[] domains;

    private String logoutSuccessUrl;

    public CustomLogoutSuccessHandler(String[] domains, String logoutSuccessUrl) {
        this.domains = domains;
        this.logoutSuccessUrl = logoutSuccessUrl;
        this.setDefaultTargetUrl(logoutSuccessUrl);
    }

    @Override
    public void onLogoutSuccess(
            HttpServletRequest httpServletRequest,
            HttpServletResponse httpServletResponse,
            Authentication authentication) throws IOException, ServletException {
        String requestUrl = httpServletRequest.getRequestURL().toString();
        String defaultTargetUrl = this.logoutSuccessUrl;

        boolean flag = false;
        for (String domain : this.domains) {
            if (requestUrl.startsWith(domain)) {
                flag = true;
                break;
            }
        }

        if (!flag) {
            defaultTargetUrl = "/sign-in";
        } else {
            String redirectUrl = requestUrl.replace(httpServletRequest.getRequestURI(), "");
            String previousPage = CookieUtils.getValue(httpServletRequest, "previous_page");
            if (!StringUtils.isEmpty(previousPage)) {
                redirectUrl = redirectUrl + previousPage;
            } else {
                redirectUrl = redirectUrl + httpServletRequest.getContextPath();
            }
            defaultTargetUrl = defaultTargetUrl + String.format("?redirectUrl=%s", redirectUrl);
        }
        this.setDefaultTargetUrl(defaultTargetUrl);
        this.handle(httpServletRequest, httpServletResponse, authentication);
    }
}
