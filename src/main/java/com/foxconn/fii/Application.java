package com.foxconn.fii;

import com.foxconn.fii.common.exception.CommonException;
import com.foxconn.fii.common.utils.SftpUtils;
import com.foxconn.fii.config.ApplicationConstant;
import com.foxconn.fii.main.config.MainSchedulerConfig;
import com.foxconn.fii.main.data.primary.model.entity.WebAccessHistory;
import com.foxconn.fii.main.data.primary.repository.WebAccessHistoryRepository;
import com.foxconn.fii.main.data.primary.repository.WebLogPathRepository;
import com.jcraft.jsch.IO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
@SpringBootApplication
@RestController
public class Application extends SpringBootServletInitializer implements CommandLineRunner {

    @PostConstruct
    public void init() {
        TimeZone.setDefault(TimeZone.getTimeZone("GMT+7:00"));
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    @Bean
    @Primary
    public TaskScheduler taskScheduler() {
        ThreadPoolTaskScheduler threadPoolTaskScheduler = new ThreadPoolTaskScheduler();
        threadPoolTaskScheduler.setPoolSize(20);
        threadPoolTaskScheduler.setThreadNamePrefix("ThreadPoolTaskScheduler");
        return threadPoolTaskScheduler;
    }

    @Autowired
    private WebLogPathRepository webLogPathRepository;

    @Autowired
    private WebAccessHistoryRepository webAccessHistoryRepository;

    @Autowired
    private MainSchedulerConfig mainSchedulerConfig;

    @Override
    public void run(String... args) throws Exception {
//        String logPath = "D:\\tiennd\\app\\apache24\\logs\\";
////        String logPath = "C:\\Users\\V0946495.VNGZ\\Desktop\\";
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
//
////                        for (int i = 1; i <= matcher.groupCount(); i++) {
////                            matcher.group(i);
////                        }
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

//        mainSchedulerConfig.backupMedia();

        log.info("### RUN OK");
    }

}
