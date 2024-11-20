package com.foxconn.fii.security.exception;

import org.springframework.security.core.AuthenticationException;

public class JwtTokenExpiredException extends AuthenticationException {
    private static final long serialVersionUID = -5959543783324224864L;
    
    private String token;

    public JwtTokenExpiredException(String msg) {
        super(msg);
    }

    public JwtTokenExpiredException(String token, String msg, Throwable t) {
        super(msg, t);
        this.token = token;
    }

    public String token() {
        return this.token;
    }
}
