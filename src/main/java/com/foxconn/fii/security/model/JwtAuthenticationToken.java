package com.foxconn.fii.security.model;

import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class JwtAuthenticationToken extends AbstractAuthenticationToken {
    private static final long serialVersionUID = 2877954820905567501L;

    private String username;

    private JwtTokenWrapper jwtTokenWrapper;

    public JwtAuthenticationToken(JwtTokenWrapper unsafeAccessToken) {
        super(null);
        this.jwtTokenWrapper = unsafeAccessToken;
        this.setAuthenticated(false);
    }

    public JwtAuthenticationToken(String username, Collection<? extends GrantedAuthority> authorities) {
        super(authorities);
        this.eraseCredentials();
        this.username = username;
        super.setAuthenticated(true);
    }

    public JwtAuthenticationToken(String unsafeAccessToken, String username, Collection<? extends GrantedAuthority> authorities) {
        super(authorities);
        this.eraseCredentials();
        this.username = username;
        this.jwtTokenWrapper = new JwtTokenWrapper();
        this.jwtTokenWrapper.setAccessToken(unsafeAccessToken);
        super.setAuthenticated(true);
    }

    @Override
    public void setAuthenticated(boolean authenticated) {
        if (authenticated) {
            throw new IllegalArgumentException(
                    "Cannot set this token to trusted - use constructor which takes a GrantedAuthority list instead");
        }
        super.setAuthenticated(false);
    }

    @Override
    public Object getCredentials() {
        return this.jwtTokenWrapper;
    }

    @Override
    public Object getPrincipal() {
        return this.username;
    }

    @Override
    public void eraseCredentials() {
        super.eraseCredentials();
        this.jwtTokenWrapper = null;
    }
}
