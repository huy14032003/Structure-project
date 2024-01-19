package com.foxconn.fii.security.service;

import com.foxconn.fii.security.model.JwtTokenResponse;
import com.foxconn.fii.security.model.OAuth2User;
import com.foxconn.fii.security.model.UserContext;

public interface OAuth2Service {

    JwtTokenResponse getClientCredentialsToken();

    JwtTokenResponse getAccessToken(String username, String password, String mfaType, String mfaValue, String uuid);

    UserContext getUserDetails(String username);

    OAuth2User searchUserInformation(String username);

    OAuth2User getCurrentUser();

    OAuth2User getCurrentUserInformation();

    void changePassword(String oldPassword, String newPassword);
}
