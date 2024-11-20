package com.foxconn.fii.common.utils;

import lombok.experimental.UtilityClass;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;

@UtilityClass
public class CommonUtils {

    public boolean validateEmail(String email) {
        String regex = "^[\\w-_/\\.+]*[\\w-_/\\.]\\@([\\w-_\\.]+\\.)+[\\w-_\\.]+[\\w-_\\.]$";
        return email.matches(regex);
    }

    public String getExtension(String filename) {
        if (filename == null) {
            return "";
        } else {
            int index = filename.lastIndexOf(".");
            return index == -1 ? "" : filename.substring(index + 1);
        }
    }

    public String getClientIP(HttpServletRequest request) {
        String clientIP = request.getHeader("x-forwarded-for");
        if (StringUtils.isEmpty(clientIP)) {
            clientIP = request.getRemoteAddr();
        } else if (clientIP.contains(",")) {
            clientIP = clientIP.split(",")[0];
        }
        return clientIP;
    }
}
