package com.foxconn.fii.security.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.util.StringUtils;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Slf4j
public class LanguageFilter implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        if (servletRequest instanceof HttpServletRequest &&
                servletResponse instanceof HttpServletResponse) {
            HttpServletRequest request = (HttpServletRequest) servletRequest;
            HttpServletResponse response = (HttpServletResponse) servletResponse;

            if (request.getRequestURI().contains("/login")) {
                log.debug("### filter language process");
                String lang = request.getParameter("lang");
                if (!StringUtils.isEmpty(lang)) {
                    Cookie cookie = new Cookie("lang", lang);
//                    cookie.setSecure(true);
//                    cookie.setHttpOnly(true);
                    cookie.setPath("/");
                    response.addCookie(cookie);
                }
            }

            if (!request.getRequestURI().contains("/favicon.ico") &&
                    !request.getRequestURI().contains("/login") &&
                    !request.getRequestURI().contains("/sign-in") &&
                    !request.getRequestURI().contains("/handle-login-success") &&
                    !request.getServletPath().substring(1).contains("/")) {

                String url = request.getRequestURI();
                if (!StringUtils.isEmpty(request.getQueryString())) {
                    url += "?" + request.getQueryString();
                }
                Cookie cookie = new Cookie("previous_page", url);
                cookie.setSecure(true);
                cookie.setHttpOnly(true);
                cookie.setPath("/");
                response.addCookie(cookie);
            }
        }

        filterChain.doFilter(servletRequest, servletResponse);
    }
}
