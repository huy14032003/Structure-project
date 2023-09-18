package com.foxconn.fii.main.config;

import com.foxconn.fii.common.utils.SftpUtils;
import com.foxconn.fii.config.ApplicationConstant;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSchException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

@Slf4j
@Configuration
public class MainSchedulerConfig {

    @Value("${path.data}")
    private String dataPath;

    @Value("${path.temp}")
    private String tempPath;

    @Value("${server.servlet.context-path}")
    private String contextPath;


//    @Scheduled(cron = "0 0 9 * * THU")
//    @Scheduled(cron = "0 33 * * * *")
//    public void sampleFunction() {
//
//    }


    @Scheduled(cron = "0 0/5 * * * *")
    public void backupMedia() {
        try {
            ChannelSftp channelSftp = SftpUtils.createChannel(
                    ApplicationConstant.SFTP_HOST,
                    ApplicationConstant.SFTP_PORT,
                    ApplicationConstant.SFTP_USERNAME,
                    ApplicationConstant.SFTP_PASSWORD);

            channelSftp.connect();

            File tempFolder = new File(tempPath);
            backupFiles(channelSftp, tempFolder);

            channelSftp.exit();
        } catch (Exception e) {
            log.error("### backup media error", e);
        }
    }

    private void backupFiles(ChannelSftp channelSftp, File path) {
        File[] files = path.listFiles();
        if (files != null) {
            for (File file : files) {
                try {
                    String filePath = file.getPath().replace("\\", "/").replace(tempPath, "");
                    if (file.isFile()) {
                        channelSftp.put(file.getPath(), contextPath + "/" + filePath);
                        Files.move(file.toPath(), Paths.get(dataPath + filePath));
                    } else {
                        try {
                            channelSftp.stat(contextPath + "/" + filePath);
                        } catch (Exception e) {
                            channelSftp.mkdir(contextPath + "/" + filePath);
                        }
                        Files.createDirectories(Paths.get(dataPath + filePath));
                        backupFiles(channelSftp, file);
                    }
                } catch (Exception e) {
                    log.error("### backup files error", e);
                }
            }
        }
    }
}
