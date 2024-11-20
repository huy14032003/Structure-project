package com.foxconn.fii.security.config;

import org.springframework.security.oauth2.client.filter.state.DefaultStateKeyGenerator;
import org.springframework.security.oauth2.client.resource.OAuth2ProtectedResourceDetails;
import org.springframework.security.oauth2.common.util.RandomValueStringGenerator;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;
import org.springframework.util.StringUtils;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;

public class RedirectUrlStateKeyGenerator extends DefaultStateKeyGenerator {
    private RandomValueStringGenerator generator = new RandomValueStringGenerator();
    private RequestCache requestCache = new HttpSessionRequestCache();

    @Override
    public String generateKey(OAuth2ProtectedResourceDetails resource) {

        SavedRequest request = getSavedRequest();
        if (request != null) {
            String redirectUrl = request.getRedirectUrl();
            if (!StringUtils.isEmpty(redirectUrl)) {
                return generator.generate() + "," + redirectUrl;
            }
        }

//        HttpServletRequest request = getCurrentHttpServletRequest();
//        if (request != null) {
//            String referer = request.getHeader("Referer");
//            if (!StringUtils.isEmpty(referer)) {
//                return generator.generate() + "," + referer;
//            }
//        }

        return generator.generate();
    }

    private SavedRequest getSavedRequest() {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        if (requestAttributes instanceof ServletRequestAttributes) {
            return requestCache.getRequest(((ServletRequestAttributes)requestAttributes).getRequest(), ((ServletRequestAttributes)requestAttributes).getResponse());
        }
        return null;
    }

    private static HttpServletRequest getCurrentHttpServletRequest() {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        if (requestAttributes instanceof ServletRequestAttributes) {
            return ((ServletRequestAttributes)requestAttributes).getRequest();
        }
        return null;
    }
}
