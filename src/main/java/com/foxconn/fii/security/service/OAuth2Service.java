package com.foxconn.fii.security.service;

import com.foxconn.fii.security.model.JwtTokenWrapper;
import com.foxconn.fii.security.model.OAuth2User;
import com.foxconn.fii.security.model.UserContext;

public interface OAuth2Service {

    JwtTokenWrapper getClientCredentialsToken();

    JwtTokenWrapper getAccessToken(String username, String password, String mfaType, String mfaValue, String uuid);

    JwtTokenWrapper getAccessToken(String refreshToken);

    UserContext getUserDetails(String accessToken, String refreshToken);

    UserContext getUserDetails(String username);

    OAuth2User searchUserInformation(String username);

    OAuth2User getCurrentUser();

    OAuth2User getCurrentUserInformation();

    void changePassword(String oldPassword, String newPassword);
}
