package com.foxconn.fii.test;

import com.foxconn.fii.common.exception.CommonException;
import com.foxconn.fii.main.service.SampleService;
import com.foxconn.fii.main.service.impl.SampleServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.junit.Test;
//import org.junit.jupiter.api.Test;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.Reader;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
public class MainTest {

    @Test
    public void sopTest() {
        SampleService sampleService = new SampleServiceImpl();

        String folderPath = "C:\\Users\\V0946495.VNGZ\\Desktop\\agile";
//        String folderPath = "E:\\desktop\\textSOP";
        sampleService.readTextFromFolder(folderPath);

//        String pdfFile = "C:\\Users\\V0946495.VNGZ\\Desktop\\output\\agile134719924.xlsx.pdf";
//        String folder = "C:\\Users\\V0946495.VNGZ\\Desktop\\output";
//        PdfUtils.convertPdfToImage(new File(pdfFile), folder, "");

    }

//    @Test
    public void mainTest() {
//        StringBuilder sb = new StringBuilder("exxx");
//        sb.append("1");
//        log.info("{}", sb.toString());
//
//        List<PmShortageShippingMode> list = new ArrayList<>();
//        PmShortageShippingMode s = new PmShortageShippingMode();
//        s.setSupplier("1");
//        list.add(s);
//
//        Map<String, PmShortageSchedule.ShippingMode> shippingMap = list
//                .stream().collect(Collectors.toMap(PmShortageShippingMode::getSupplier, PmShortageShippingMode::getShippingMode, (s1, s2) -> s1));

        String commitEta = "2022/05/27*130000;2022/04/29*120000,2022/02/25*70000,2022/01/25*90000,2022/03/25*80000,2021/12/24*90000,2022/06/24*20000";
        String[] commits = commitEta.split("[;,]");
        String commitQtyNumber = "200K";
        commitQtyNumber = commitQtyNumber.substring(0, commitQtyNumber.length() - 1);
        String eta = "2022/02/18";
        boolean flag = eta.length() > 2 && eta.charAt(2) == '/';

        String s = "\"3,2 4-6_\"";
        s = s.replaceAll("[-_\\s\"]", "");

        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MILLISECOND, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        Date now = calendar.getTime();

        log.info("{}", s);
    }

//    @Test
    public void readLogTest() throws Exception {

        Reader fileReader = new FileReader("C:\\Users\\V0946495.VNGZ\\Desktop\\httpd-access.2023.04.29.log");
        try (BufferedReader reader = new BufferedReader(fileReader)) {
//        try (BufferedReader reader = new BufferedReader(new FileReader("C:\\Users\\V0946495\\Desktop\\SD report\\20210113\\ZNM22.xls"))) {
            Calendar calendar = Calendar.getInstance();
            calendar.setFirstDayOfWeek(Calendar.MONDAY);

            int index = 0;
            String row;
            while ((row = reader.readLine()) != null) {

                Pattern pattern = Pattern.compile("(.*) (.*) (.*) (\\[.*\\]) (.*) (.*) (\".*\") (.*) (\".*\") (\".*\") (.*)");
                Matcher matcher = pattern.matcher(row);

                List<String> cellList = new ArrayList<>();
                while (matcher.find()) {
                    for (int i=1; i<=matcher.groupCount(); i++) {
                        cellList.add(matcher.group(i));
                    }
                }

                if (cellList.size() != 11) {
                    continue;
                }

                log.debug("### {}", cellList);
            }
        } catch (Exception e) {
            log.error("### process znm22 error", e);
            throw new CommonException(String.format("process znm22 %s %s", e.getCause(), e.getMessage()));
        }

    }

//    @Test
//    public void seleniumEdge() {
////        System.setProperty("webdriver.gecko.driver","C:\\geckodriver.exe");
////        WebDriver driver = new FirefoxDriver();
//
//        //comment the above 2 lines and uncomment below 2 lines to use Chrome
//        EdgeOptions options = new EdgeOptions();
////        Map<String, Object> chromeOptionMap = new HashMap<>();
////        chromeOptionMap.put("plugins.plugins_disabled", new String[] {"Chrome PDF Viewer"});
//
////        options.addArguments("--headless");
////        options.addArguments("--disable-gpu");
////        options.addArguments("--print-to-pdf");
////        options
//
//        // setting headless mode to true.. so there isn't any ui
////        options.setHeadless(true);
//
//        System.setProperty("webdriver.edge.driver", "D:\\tiennd\\msedgedriver.exe");
////        options.setBinary("")
//        WebDriver driver = new EdgeDriver(options);
//
//        String baseUrl = "https://fiisw-cns.myfiinet.com/";
//        String expectedTitle = "Welcome: Mercury Tours";
//        String actualTitle = "";
//
//        // launch Fire fox and direct it to the Base URL
//        driver.get(baseUrl);
//
////        driver.findElement(By.cssSelector("input[name='userName']")).sendKeys("hello");
////        driver.findElement(By.cssSelector("input[name='password']")).sendKeys("world");
////        Select selectbox = new Select(driver.findElement(By.name("country")));
////        selectbox.selectByVisibleText("ANTARCTICA");
//
//        // get the actual value of the title
//        actualTitle = driver.getTitle();
//
//        /*
//         * compare the actual title of the page with the expected one and print
//         * the result as "Passed" or "Failed"
//         */
//        if (actualTitle.contentEquals(expectedTitle)){
//            System.out.println("Test Passed!");
//        } else {
//            System.out.println("Test Failed");
//        }
//
//        //close Fire fox
//        driver.close();
//    }
}
