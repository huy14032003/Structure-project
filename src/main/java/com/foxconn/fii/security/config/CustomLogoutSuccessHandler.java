package com.foxconn.fii.security.config;

import com.foxconn.fii.common.utils.CookieUtils;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AbstractAuthenticationTargetUrlRequestHandler;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.util.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
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
            HttpServletRequest request,
            HttpServletResponse response,
            Authentication authentication) throws IOException, ServletException {
//        for (Cookie cookie : request.getCookies()) {
//            if ("lang".equalsIgnoreCase(cookie.getName()) || "previous_page".equalsIgnoreCase(cookie.getName())) {
//                continue;
//            }
//
//            Cookie clearingCookie = new Cookie(cookie.getName(), null);
//            clearingCookie.setMaxAge(0);
//            clearingCookie.setPath(clearingCookie.getPath());
//            response.addCookie(clearingCookie);
//        }

        String requestUrl = request.getRequestURL().toString();
        String defaultTargetUrl = this.logoutSuccessUrl;

        boolean trustFlag = false;
        for (String domain : this.domains) {
            if (requestUrl.startsWith(domain)) {
                trustFlag = true;
                break;
            }
        }

        if (!trustFlag) {
//            defaultTargetUrl = "/sign-in";
            defaultTargetUrl = requestUrl.substring(0, requestUrl.indexOf("/", 10)) + defaultTargetUrl.substring(defaultTargetUrl.indexOf("/", 10));
        }


        String redirectUrl = requestUrl.replace(request.getRequestURI(), "");
        String referer = request.getHeader("referer");
        String previousPage = CookieUtils.getCookieValue(request, "previous_page");
        if (!StringUtils.isEmpty(referer)) {
            redirectUrl = referer;
        } else if (!StringUtils.isEmpty(previousPage)) {
            redirectUrl = redirectUrl + previousPage;
        } else {
            redirectUrl = redirectUrl + request.getContextPath();
        }
        defaultTargetUrl = defaultTargetUrl + String.format("?redirectUrl=%s", redirectUrl);

        this.setDefaultTargetUrl(defaultTargetUrl);
        this.handle(request, response, authentication);
    }
}
