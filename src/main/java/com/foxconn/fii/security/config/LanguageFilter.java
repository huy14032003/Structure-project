package com.foxconn.fii.security.config;

import com.foxconn.fii.common.utils.CookieUtils;
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
//                log.debug("### filter language process");
                String lang = request.getParameter("lang");
                if (!StringUtils.isEmpty(lang)) {
                    CookieUtils.create(request, response, "lang", lang, 14 * 24 * 60 * 60);
                }
            }

            if (!request.getRequestURI().contains("/favicon.ico") &&
                    !request.getRequestURI().contains("/login") &&
                    !request.getRequestURI().contains("/sign-in") &&
                    !request.getRequestURI().contains("/handle-login-success") &&
                    !request.getServletPath().contains("/error") &&
                    !request.getServletPath().contains("/page") &&
                    !request.getServletPath().contains("/assets") &&
                    !request.getServletPath().contains("/ws-data") &&
                    !request.getServletPath().contains("/myjs") &&
                    !request.getServletPath().contains("/templates") &&
                    !request.getServletPath().contains("/api")) {

                String url = request.getRequestURI();
                if (!StringUtils.isEmpty(request.getQueryString())) {
                    url += "?" + request.getQueryString();
                }
                CookieUtils.create(request, response, "previous_page", url, 14 * 24 * 60 * 60, true);
            }
        }

        filterChain.doFilter(servletRequest, servletResponse);
    }
}
