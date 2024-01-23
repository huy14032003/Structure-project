package com.foxconn.fii.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

@Data
@ConfigurationProperties("sftp")
public class SftpProperties {

    private String host;

    private Integer port;

    private String username;

    private String password;

}
