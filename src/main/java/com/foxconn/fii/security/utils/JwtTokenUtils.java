package com.foxconn.fii.security.utils;

import com.foxconn.fii.security.exception.JwtTokenExpiredException;
import io.jsonwebtoken.*;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.authentication.AuthenticationServiceException;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.util.StringUtils;

import java.security.PublicKey;

import static com.foxconn.fii.security.config.JwtProperties.BEARER_TOKEN_PREFIX;

@Slf4j
@UtilityClass
public class JwtTokenUtils {

    public static String extractJwtTokenHeader(String header) {
        if (StringUtils.isEmpty(header)) {
            throw new AuthenticationServiceException("Authorization header cannot be blank!");
        }

        if (!header.startsWith(BEARER_TOKEN_PREFIX)) {
            throw new AuthenticationServiceException("Invalid authorization header format.");
        }

        return header.substring(BEARER_TOKEN_PREFIX.length());
    }

    public static Jws<Claims> parseClaims(String jwtToken, PublicKey signingKey) {
        try {
            return Jwts.parser().setSigningKey(signingKey).parseClaimsJws(jwtToken);
        } catch (UnsupportedJwtException | MalformedJwtException | IllegalArgumentException | SignatureException ex) {
            log.error("Invalid JWT Token", ex);
            throw new BadCredentialsException("Invalid JWT token: ", ex);
        } catch (ExpiredJwtException expiredEx) {
            log.info("JWT Token is expired", expiredEx);
            throw new JwtTokenExpiredException(jwtToken, "JWT Token expired", expiredEx);
        }
    }

    public static Jws<Claims> parseClaims(String jwtToken, String signingKey) {
        try {
            return Jwts.parser().setSigningKey(signingKey).parseClaimsJws(jwtToken);
        } catch (UnsupportedJwtException | MalformedJwtException | IllegalArgumentException | SignatureException ex) {
            log.error("Invalid JWT Token", ex);
            throw new BadCredentialsException("Invalid JWT token: ", ex);
        } catch (ExpiredJwtException expiredEx) {
            log.info("JWT Token is expired", expiredEx);
            throw new JwtTokenExpiredException(jwtToken, "JWT Token expired", expiredEx);
        }
    }
}
