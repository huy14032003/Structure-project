package com.foxconn.fii.security.jwt.model.token;

import org.springframework.security.authentication.AbstractAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class JwtAuthenticationToken extends AbstractAuthenticationToken {
    private static final long serialVersionUID = 2877954820905567501L;

    private RawToken rawToken;
    private String username;

    public JwtAuthenticationToken(RawToken unsafeToken) {
        super(null);
        this.rawToken = unsafeToken;
        this.setAuthenticated(false);
    }

    public JwtAuthenticationToken(String username, Collection<? extends GrantedAuthority> authorities) {
        super(authorities);
        this.eraseCredentials();
        this.username = username;
        super.setAuthenticated(true);
    }

    public JwtAuthenticationToken(String unsafeToken, String username, Collection<? extends GrantedAuthority> authorities) {
        super(authorities);
        this.eraseCredentials();
        this.rawToken = new RawToken(unsafeToken);
        this.username = username;
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
        return this.rawToken;
    }

    @Override
    public Object getPrincipal() {
        return this.username;
    }

    @Override
    public void eraseCredentials() {
        super.eraseCredentials();
        this.rawToken = null;
    }
}
