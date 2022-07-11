package com.foxconn.fii.security.service;

import com.foxconn.fii.security.model.JwtTokenResponse;
import com.foxconn.fii.security.model.OAuth2User;
import com.foxconn.fii.security.model.UserContext;
import org.springframework.security.core.userdetails.UserDetails;

public interface OAuth2Service {

    UserContext getUserInformation(String username);

    OAuth2User getCurrentUser();

    JwtTokenResponse getToken(String username, String password, String uuid);

    OAuth2User getCurrentUserInformation();

    void changePassword(String oldPassword, String newPassword);
}
