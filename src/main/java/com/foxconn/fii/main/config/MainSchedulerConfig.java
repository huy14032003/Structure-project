package com.foxconn.fii.main.config;

import com.foxconn.fii.common.utils.SftpUtils;
import com.foxconn.fii.config.SftpProperties;
import com.jcraft.jsch.ChannelSftp;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Scheduled;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
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
//    @Scheduled(cron = "${batch.cron.sample}")
//    @Scheduled(fixedDelayString = "30000", initialDelayString = "60000")
//    public void sampleFunction() {
//
//    }


    @Scheduled(cron = "${batch.cron.backup-media}")
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
                            Files.move(file.toPath(), Paths.get(dataPath + filePath), StandardCopyOption.REPLACE_EXISTING);
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

//    private void backupLogs() {
//        String logPath = "D:\\tiennd\\app\\apache24\\logs\\";
//        for (int day = 1; day <= 30; day++) {
//            String filePath = logPath + String.format("httpd-access.2023.04.%02d.log", day);
//            log.debug("### {}", filePath);
//            try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
//
//                int index = 0;
//                List<WebAccessHistory> accessList = new ArrayList<>();
//
//                String row;
//                while ((row = reader.readLine()) != null) {
//
//                    Pattern pattern = Pattern.compile("(.*) (.*) (.*) (\\[.*\\]) (.*) (.*) (\".*\") (.*) (\".*\") (\".*\") (.*)");
//                    Matcher matcher = pattern.matcher(row);
//
//                    while (matcher.find()) {
//                        if (matcher.groupCount() < 11) {
//                            continue;
//                        }
//
//                        try {
//                            WebAccessHistory access = new WebAccessHistory();
//                            access.setIpAddress(matcher.group(1));
//                            access.setAccessTime(matcher.group(4));
//                            access.setProcessTime(matcher.group(5) + " " + matcher.group(6));
//
//                            String[] url = matcher.group(7).split(" ");
//                            if (url.length == 3) {
//                                access.setUrl(url[1]);
//                                access.setHttpProtocol(url[2].replaceAll("\"", ""));
//                                access.setHttpMethod(url[0].replaceAll("\"", ""));
//                            } else {
//                                access.setUrl(matcher.group(7));
//                            }
//
//                            access.setHttpStatus(matcher.group(8));
//                            access.setSource(matcher.group(9));
//                            access.setBrowser(matcher.group(10));
//                            access.setLength(matcher.group(11));
//                            accessList.add(access);
//                        } catch (Exception e) {
//                            log.error("### error", e);
//                        }
//                    }
//
//                    index ++;
//                    if (index == 1000) {
//                        webAccessHistoryRepository.saveAll(accessList);
//
//                        index = 0;
//                        accessList = new ArrayList<>();
//                    }
//
//                }
//            } catch (Exception e) {
//                log.error("### process log error", e);
////                throw new CommonException(String.format("process log %s %s", e.getCause(), e.getMessage()));
//            }
//        }
//    }
}
