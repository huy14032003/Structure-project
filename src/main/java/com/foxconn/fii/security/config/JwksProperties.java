package com.foxconn.fii.security.config;

import lombok.Data;

import java.math.BigInteger;
import java.security.KeyFactory;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.util.Base64;
import java.util.List;

@Data
public class JwksProperties {

    private List<Key> keys;

    @Data
    public static class Key {
        private String kty;
        private String use;
        private String alg;
        private String kid;
        private String n;
        private String e;

        private PublicKey publicKey;

        public void loadPublicKey() throws Exception {
            RSAPublicKeySpec spec = new RSAPublicKeySpec(new BigInteger(1, Base64.getUrlDecoder().decode(this.n)), new BigInteger(1, Base64.getUrlDecoder().decode(this.e)));
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            this.publicKey = keyFactory.generatePublic(spec);
        }
    }
}
