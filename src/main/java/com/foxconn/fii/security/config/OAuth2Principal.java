package com.foxconn.fii.security.config;

import com.foxconn.fii.security.model.OAuth2User;
import org.springframework.security.core.Authentication;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.OAuth2Request;

public class OAuth2Principal extends OAuth2Authentication {

    private OAuth2User user;

    public OAuth2Principal(OAuth2Authentication auth2Authentication, OAuth2User user) {
        super(auth2Authentication.getOAuth2Request(), auth2Authentication.getUserAuthentication());
        this.user = user;
    }

    public OAuth2Principal(OAuth2Request storedRequest, Authentication userAuthentication) {
        super(storedRequest, userAuthentication);
    }

    public OAuth2User getUser() {
        return user;
    }
}
