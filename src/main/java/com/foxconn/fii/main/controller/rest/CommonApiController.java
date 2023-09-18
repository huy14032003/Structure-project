package com.foxconn.fii.main.controller.rest;

import com.foxconn.fii.common.exception.CommonException;
import com.foxconn.fii.common.response.CommonResponse;
import com.foxconn.fii.common.response.ListResponse;
import com.foxconn.fii.common.utils.CommonUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.MessageSource;
import org.springframework.http.MediaType;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@RestController
public class CommonApiController {

    @Autowired
    private MessageSource messageSource;

    @Value("${path.data}")
    private String dataPath;

    @Value("${server.servlet.context-path}")
    private String contextPath;

    @Value("${server.servlet.static-path}")
    private String staticPath;


    @GetMapping("/api/greeting")
    public String greeting(HttpServletRequest request, Locale locale) {
//        return "Welcome to HR system!\n--- VN FII Team ---";
        return messageSource.getMessage("greeting", null, locale);
    }

    @GetMapping("/api/time/now")
    public String getTimeNow() {
        SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar calendar = Calendar.getInstance();
        return df.format(calendar.getTime());
    }

    @PostMapping(value = {"/api/upload/{fileType}"}, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ListResponse<String> uploadFile(
            @PathVariable String fileType,
            @RequestPart MultipartFile[] files,
            @RequestAttribute(required = false) Integer originalFlag) {

        if (!"|public|tmp|file|image|audio|video|".contains("|" + fileType + "|")) {
            throw CommonException.of("File type {} is not support", fileType);
        }

        if (files.length <= 0 || files.length > 9) {
            throw CommonException.of("Files length greater than 0 and less than 10!");
        }

        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);
        int day = calendar.get(Calendar.DAY_OF_MONTH);

        String subPath = fileType + "/" + year + "/" + month + "/" + day;
        Path folderPath = Paths.get(dataPath + subPath);
        try {
            Files.createDirectories(folderPath);
        } catch (Exception e) {
            throw CommonException.of("Can not create {} folder", folderPath);
        }

        List<String> urlList = new ArrayList<>();
        for (MultipartFile multipartFile : files) {
            String filename = multipartFile.getOriginalFilename();
            if (originalFlag == null || originalFlag == 0) {
                String name = System.currentTimeMillis() + "-" + new Random().nextInt(100);
                String extension = CommonUtils.getExtension(multipartFile.getOriginalFilename());
                if (!StringUtils.isEmpty(extension)) {
                    extension = "." + extension;
                }
                filename = name + extension;
            }

            File file = new File(dataPath + subPath + "/" + filename);
            String url = contextPath + staticPath + "/" + subPath + "/" + filename;

            try {
                multipartFile.transferTo(file);
                urlList.add(url);
            } catch (IOException e) {
                log.error("### upload {} error", fileType, e);
            }
        }

        return ListResponse.success(urlList);
    }
}
