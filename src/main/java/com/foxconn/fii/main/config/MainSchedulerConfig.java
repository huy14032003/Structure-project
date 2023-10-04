package com.foxconn.fii.main.config;

import com.foxconn.fii.common.model.SftpProperties;
import com.foxconn.fii.common.utils.SftpUtils;
import com.jcraft.jsch.ChannelSftp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.attribute.FileTime;

@Slf4j
@Configuration
public class MainSchedulerConfig {

    @Value("${path.data}")
    private String dataPath;

    @Value("${path.temp}")
    private String tempPath;

    @Value("${server.servlet.context-path}")
    private String contextPath;

    @Autowired
    private SftpProperties sftpProperties;


//    @Scheduled(cron = "0 0 9 * * THU")
//    @Scheduled(cron = "0 33 * * * *")
//    public void sampleFunction() {
//
//    }


    @Scheduled(cron = "0 0/15 * * * *")
    public void backupMedia() {
        log.info("### backup media START");
        try {
            ChannelSftp channelSftp = SftpUtils.createChannel(
                    sftpProperties.getHost(),
                    sftpProperties.getPort(),
                    sftpProperties.getUsername(),
                    sftpProperties.getPassword());

            channelSftp.connect();

            File tempFolder = new File(tempPath);
            try {
                channelSftp.stat("/media" + contextPath);
            } catch (Exception e) {
                channelSftp.mkdir("/media" + contextPath);
            }

            backupFiles(channelSftp, tempFolder);

            channelSftp.exit();
        } catch (Exception e) {
            log.error("### backup media error", e);
        }
        log.info("### backup media END");
    }

    private void backupFiles(ChannelSftp channelSftp, File path) {
        File[] files = path.listFiles();
        if (files != null) {
            for (File file : files) {
                try {
                    FileTime creationTime = (FileTime) Files.getAttribute(file.toPath(), "creationTime");
                    if (System.currentTimeMillis() - 5 * 60 * 1000 < creationTime.toMillis()) {
                        continue;
                    }

                    String filePath = file.getPath().replace("\\", "/").replace(tempPath, "");
                    if (file.isFile()) {
                        channelSftp.put(file.getPath(), "/media" + contextPath + "/" + filePath);
                        try {
                            Files.move(file.toPath(), Paths.get(dataPath + filePath));
                        } catch (Exception e) {
                            Files.move(file.toPath(), Paths.get(dataPath + filePath + ".err"));
                        }
                    } else {
                        try {
                            channelSftp.stat("/media" + contextPath + "/" + filePath);
                        } catch (Exception e) {
                            channelSftp.mkdir("/media" + contextPath + "/" + filePath);
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
