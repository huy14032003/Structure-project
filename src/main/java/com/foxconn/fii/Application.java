package com.foxconn.fii;

import com.foxconn.fii.main.data.primary.model.entity.SopAgile;
import com.foxconn.fii.main.data.primary.repository.SopAgileRepository;
import com.foxconn.fii.main.service.SampleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Primary;
import org.springframework.scheduling.TaskScheduler;
import org.springframework.scheduling.concurrent.ThreadPoolTaskScheduler;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.PostConstruct;
import java.io.File;
import java.util.Arrays;
import java.util.List;
import java.util.TimeZone;

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
    private SampleService sampleService;

    @Autowired
    private SopAgileRepository sopAgileRepository;

    @Value("${path.tmp}")
    private String tmpPath;

    @Override
    public void run(String... args) throws Exception {
//        List<String> codeList = Arrays.asList("SOP-NVD-AA",
//                "SOP-NVA2-AA",
//                "SOP-NVA2-KM");
//
//        for (String code : codeList) {
//            List<SopAgile> sopAgileList = sopAgileRepository.getSopAgileMapping(code + "%");
//            for (SopAgile agile : sopAgileList) {
//                String filePathString = String.valueOf(agile.getAgileFileName());
//                if (filePathString == null/* || !filePathString.equals("211092175")*/) {
//                    continue;
//                }
//
//                try {
//                    String path1 = filePathString.substring(0, 2);
//                    String path2 = filePathString.substring(2, 4);
//                    String path3 = filePathString.substring(4, 6);
//                    String filePath = /*"SOP/" +*/ path1 + "/" + path2 + "/" + path3 + "/agile" + filePathString + "." + agile.getFileType();
//
////                    String folderPath = "C:\\Users\\V0946495.VNGZ\\Desktop\\agile";
//                    File file = new File(tmpPath + "/" + filePath);
//                    sampleService.readTextFromExcel(file);
//                } catch (Exception e) {
//                    log.error("### error", e);
//                }
//            }
//        }

////        sampleService.readTextFromExcel(tmpPath);
//        String folderPath = "C:\\Users\\V0946495.VNGZ\\Desktop\\agile";
////        String folderPath = "E:\\desktop\\textSOP";
//        sampleService.readTextFromFolder(folderPath);

//        List<String> list1 = sampleService.generateList(10);
//        List<String> list2 = sampleService.generateList(10);
//        List<String> list3 = sampleService.generateList(10);
//        List<String> list4 = sampleService.generateList(100);
//        List<String> list5 = sampleService.generateList(100);

        log.info("### RUN OK");
    }

}
