package com.foxconn.fii.main.controller.rest;

import com.foxconn.fii.common.exception.CommonException;
import com.foxconn.fii.common.response.CommonResponse;
import com.foxconn.fii.common.response.ListResponse;
import com.foxconn.fii.common.utils.CommonUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hssf.usermodel.HSSFFormulaEvaluator;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellReference;
import org.apache.poi.xssf.usermodel.XSSFFormulaEvaluator;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
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

//    @Value("${path.data}")
//    private String dataPath;

    @Value("${path.temp}")
    private String tempPath;

    @Value("${server.servlet.context-path}")
    private String contextPath;

    @Value("${server.servlet.static-path}")
    private String staticPath;

    @Value("${server.mode}")
    private String serverMode;


    @GetMapping("/api/greeting")
    public String greeting(HttpServletRequest request, Locale locale) {
//        return "Welcome to sample-system system!\n--- VN FII Team ---";
        return messageSource.getMessage("greeting", null, locale);
    }

    @GetMapping("/api/time/now")
    public String getTimeNow() {
        SimpleDateFormat df = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        Calendar calendar = Calendar.getInstance();
        return df.format(calendar.getTime());
    }

    @GetMapping("/api/health/check")
    public String getHealthCheck() {
        return serverMode;
    }

    /**
     * @param fileType |public| ignore security
     *                 |tmp| removable
     *                 |file|image|audio|video| file type of file
     * @param files files
     * @param originalFlag 1: keep original file name
     * @return urls
     */

    @PostMapping(value = {"/api/upload/{fileType}"}, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ListResponse<String> uploadFile(
            @PathVariable String fileType,
            @RequestPart MultipartFile[] files,
            Integer originalFlag) {

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
        Path folderPath = Paths.get(tempPath + subPath);
        try {
            Files.createDirectories(folderPath);
        } catch (Exception e) {
            throw CommonException.of("Can not create {} folder", folderPath);
        }

        List<String> urlList = new ArrayList<>();
        for (MultipartFile multipartFile : files) {
            String filename = multipartFile.getOriginalFilename();
            if (originalFlag == null || originalFlag == 0) {
                String name = UUID.randomUUID().toString().replaceAll("-", "");
                String extension = CommonUtils.getExtension(multipartFile.getOriginalFilename());
                if (!StringUtils.isEmpty(extension)) {
                    extension = "." + extension;
                }
                filename = name + extension;
            }

            File file = new File(tempPath + subPath + "/" + filename);
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



    @PostMapping(value = {"/api/preview/excel"}, consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public CommonResponse<List<Map<String, String>>> previewExcel(@RequestPart MultipartFile uploadedFile,
                                                                  Integer headerIndex,
                                                                  Integer headerSize) {
        List<Map<String, String>> table = new ArrayList<>();

        try {
            Workbook workbook;
            FormulaEvaluator evaluator = null;
            try {
                workbook = WorkbookFactory.create(uploadedFile.getInputStream());
                if (workbook instanceof XSSFWorkbook) {
                    evaluator = new XSSFFormulaEvaluator(((XSSFWorkbook) workbook));
                } else if (workbook instanceof HSSFWorkbook) {
                    evaluator = new HSSFFormulaEvaluator(((HSSFWorkbook) workbook));
                }
            } catch (Exception e) {
                throw CommonException.of("uploaded file is not xls or xlsx file");
            }

            if (workbook.getNumberOfSheets() == 0) {
                throw CommonException.of("excel file is not include any sheet");
            }

            if (headerIndex == null || headerIndex < 0) {
                headerIndex = 0;
            }
            if (headerSize == null || headerSize < 0) {
                headerSize = 0;
            }

            Sheet sheet = workbook.getSheetAt(0);
            DataFormatter formatter = new DataFormatter();

            Map<Integer, String> headerMap = new TreeMap<>();
            for (int i = 0; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                if (row == null) {
                    continue;
                }

                if (i >= headerIndex) {
                    if (i < headerIndex + headerSize) {
                        for (Cell cell : row) {
                            headerMap.put(cell.getColumnIndex(), headerMap.getOrDefault(cell.getColumnIndex(), "") + formatter.formatCellValue(cell, evaluator));
                        }
                    } else {
                        Map<String, String> rowMap = new LinkedHashMap<>();
                        for (Cell cell : row) {
                            String key = headerMap.getOrDefault(cell.getColumnIndex(), "");
                            if (StringUtils.isEmpty(key)) {
                                key = CellReference.convertNumToColString(cell.getColumnIndex());
                            }
                            rowMap.put(key, formatter.formatCellValue(cell, evaluator));
                        }
                        table.add(rowMap);
                    }
                }
            }
        } catch (Exception e) {
            log.error("### get table data from excel file error", e);
            throw new CommonException(String.format("get table data from excel file %s %s", e.getCause(), e.getMessage()));
        }

        return CommonResponse.success(table);
    }
}
