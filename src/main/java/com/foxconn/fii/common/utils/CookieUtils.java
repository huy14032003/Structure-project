package com.foxconn.fii.common.utils;

import lombok.experimental.UtilityClass;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@UtilityClass
public class CookieUtils {

    public static void create(HttpServletRequest request, HttpServletResponse response, String name, String value, Integer maxAge) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath(request.getContextPath().length() > 0 ? request.getContextPath() : "/");
        cookie.setSecure(request.isSecure());
        response.addCookie(cookie);
    }

    public static void create(HttpServletRequest request, HttpServletResponse response, String name, String value, Integer maxAge, Boolean httpOnly) {
        Cookie cookie = new Cookie(name, value);
        cookie.setMaxAge(maxAge);
        cookie.setPath(request.getContextPath().length() > 0 ? request.getContextPath() : "/");
        cookie.setSecure(request.isSecure());
        cookie.setHttpOnly(httpOnly);
        response.addCookie(cookie);
    }

    public static void clear(HttpServletRequest request, HttpServletResponse response, String name) {
        Cookie cookie = new Cookie(name, null);
        cookie.setMaxAge(0);
        cookie.setPath(request.getContextPath().length() > 0 ? request.getContextPath() : "/");
        cookie.setSecure(request.isSecure());
        response.addCookie(cookie);
    }

    public static void clear(HttpServletRequest request, HttpServletResponse response, String name, Boolean httpOnly) {
        Cookie cookie = new Cookie(name, null);
        cookie.setMaxAge(0);
        cookie.setPath(request.getContextPath().length() > 0 ? request.getContextPath() : "/");
        cookie.setSecure(request.isSecure());
        cookie.setHttpOnly(httpOnly);
        response.addCookie(cookie);
    }

    public static Cookie getCookie(HttpServletRequest request, String name) {
        return WebUtils.getCookie(request, name);
    }

    public static String getCookieValue(HttpServletRequest request, String name) {
        Cookie cookie = WebUtils.getCookie(request, name);
        return cookie != null ? cookie.getValue() : null;
    }
}
