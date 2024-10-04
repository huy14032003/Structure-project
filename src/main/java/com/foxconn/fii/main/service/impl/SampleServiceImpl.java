package com.foxconn.fii.main.service.impl;

import com.foxconn.fii.common.exception.CommonException;
import com.foxconn.fii.common.utils.CommonUtils;
import com.foxconn.fii.main.data.primary.model.entity.TmpText;
import com.foxconn.fii.main.data.primary.repository.TmpTextRepository;
import com.foxconn.fii.main.service.SampleService;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.io.File;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Slf4j
@Service
public class SampleServiceImpl implements SampleService {

    @Autowired
    private TmpTextRepository textRepository;

    @Override
    public void readTextFromExcel(String folderPath) {
        List<String> dictionary = Arrays.asList(
                "IE", "PQE", "ME",
                "Foxconn Industrial Internet Co Ltd",
                "Communication Network Solution Business Group",
                "COMMUNICATION NETWORK SOLUTION BUSINESS GROUP",
                "Proprietary information of CNSBG"
        );

        File folder = new File(folderPath);
        if (folder.listFiles() == null) {
            throw CommonException.of("Folder is invalid");
        }

        for (File file : folder.listFiles()) {
            try {
//        File file = new File("C:\\Users\\V0946495.VNGZ\\Desktop\\textSOP\\English-SOP-NVB1-NV003A2-03  SFG103480 PTHSOP(2K) .xlsx");
                if (!file.isFile()) {
                    readTextFromExcel(file.getAbsolutePath());
//                    continue;
                }

                String extension = CommonUtils.getExtension(file.getName());
                if (!extension.equalsIgnoreCase("xls") && !extension.equalsIgnoreCase("xlsx")) {
                    continue;
                }

//            log.info("### process file '{}'", file.getName());

                Workbook workbook;
                try {
                    workbook = WorkbookFactory.create(file, null, true);
                } catch (Exception e) {
//                log.error("### read text error {}", file.getPath()/*, e*/);
                    continue;
                }

                int totalSheet = workbook.getNumberOfSheets();
                for (int i = 0; i < totalSheet; i++) {
                    if (workbook.isSheetHidden(i) || workbook.isSheetVeryHidden(i)) {
                        continue;
                    }

                    Sheet sheet = workbook.getSheetAt(i);
//                log.info("### process sheet '{}'", sheet.getSheetName());

                    List<Map<String, Object>> contentList = new ArrayList<>();

                    Map<Integer, Map<Integer, String>> textMap = processReadText(sheet);
                    saveRawText(file.getName(), sheet.getSheetName(), "TEXT", textMap);
                    for (Map.Entry<Integer, Map<Integer, String>> textMapEntry : textMap.entrySet()) {
                        contentList.addAll(processSplitLanguageText(new ArrayList<>(textMapEntry.getValue().values()), dictionary, false));

                        List<String> mergedTextList = processMergeText(textMapEntry.getValue(), dictionary);
                        contentList.addAll(processSplitLanguageText(mergedTextList, dictionary, true));
                    }

                    Map<Integer, Map<Integer, String>> textBoxMap = processReadTextBox(sheet);
                    saveRawText(file.getName(), sheet.getSheetName(), "TEXT_BOX", textBoxMap);
                    for (Map.Entry<Integer, Map<Integer, String>> textMapEntry : textBoxMap.entrySet()) {
                        contentList.addAll(processSplitLanguageText(new ArrayList<>(textMapEntry.getValue().values()), dictionary, false));
                    }

                    saveText(file.getName(), sheet.getSheetName(), contentList);
                }

                workbook.close();
            } catch (Exception e) {
                log.error("### read text from excel error", e);
            }
        }

    }

    private Map<Integer, Map<Integer, String>> processReadTextBox(Sheet sheet) {
        Map<Integer, Map<Integer, String>> textMap = new TreeMap<>();

        if (sheet instanceof XSSFSheet) {
            XSSFDrawing drawing = (XSSFDrawing) sheet.getDrawingPatriarch();
            if (drawing != null) {
                processXSSFShape(drawing, textMap, 0);
            }
        } else if (sheet instanceof HSSFSheet) {
            HSSFPatriarch patriarch = ((HSSFSheet) sheet).getDrawingPatriarch();
            if (patriarch != null) {
                processHSSFShape(patriarch, textMap, 0);
            }
        }

        return textMap;
    }

    private int processXSSFShape(ShapeContainer<XSSFShape> container, Map<Integer, Map<Integer, String>> textMap, int j) {
        for (XSSFShape shape : container) {
            if (shape instanceof XSSFSimpleShape) {
                String text = ((XSSFSimpleShape) shape).getText();
                if (text != null) {
//                    text = clearText(text);
                    if (!StringUtils.isEmpty(text)) {
                        Map<Integer, String> subTextMap = new TreeMap<>();
                        subTextMap.put(0, text);
                        textMap.put(j++, subTextMap);
                    }
                }
            }
            else if (shape instanceof XSSFShapeGroup) {
                j = processXSSFShape((XSSFShapeGroup) shape, textMap, j);
            }
        }
        return j;
    }

    private int processHSSFShape(ShapeContainer<HSSFShape> container, Map<Integer, Map<Integer, String>> textMap, int j) {
        for (HSSFShape shape : container) {
            if (shape instanceof HSSFTextbox) {
                try {
                    String text = ((HSSFTextbox) shape).getString().toString();
                    if (text != null) {
    //                    text = clearText(text);
                        if (!StringUtils.isEmpty(text)) {
                            Map<Integer, String> subTextMap = new TreeMap<>();
                            subTextMap.put(0, text);
                            textMap.put(j++, subTextMap);
                        }
                    }
                } catch (Exception ignored) {}
            }
            else if (shape instanceof HSSFShapeGroup) {
                j = processHSSFShape((HSSFShapeGroup) shape, textMap, j);
            }
        }
        return j;
    }

    private Map<Integer, Map<Integer, String>> processReadText(Sheet sheet) {
        Map<Integer, Map<Integer, String>> textMap = new TreeMap<>();

        int totalRow = Math.max(sheet.getLastRowNum(), sheet.getPhysicalNumberOfRows());
        if (totalRow <= 0) {
            return textMap;
        }

        for (int i = 0; i < totalRow; i++) {
            Row row = sheet.getRow(i);
            if (row == null) {
                continue;
            }

            int totalCell = row.getLastCellNum();
            for (int j = 0; j < totalCell; j++) {
                if (row.getCell(j) != null && row.getCell(j).getCellType() == CellType.STRING) {
                    String text = row.getCell(j).getStringCellValue();
                    if (text != null) {
//                        text = clearText(text);
                        if (!StringUtils.isEmpty(text)) {
                            Map<Integer, String> subTextMap = textMap.getOrDefault(j, new TreeMap<>());
                            subTextMap.put(i, text);
                            textMap.put(j, subTextMap);
                        }
                    }
                }
            }
        }

        return textMap;
    }

    private String clearText(String text) {
        text = addSpaceBetweenChineseTextAndNonChineseText(text);
        text = addSpaceBetweenNonChineseTextAndChineseText(text);

        text = text.replaceAll("[①②③④⑤]+", " ");
        text = text.replaceAll("[±≤≥…℃]+", " ");
        text = text.replaceAll("[※◊（）【】《》。，：；、“”﹕■□]+", " ");
        text = text.replaceAll("[~!@#$%^&*()_+`\\-=]+", " ");
        text = text.replaceAll("[:\";'<>?,./{}|]+", " ");
        text = text.replaceAll("[0-9]+", " ");
        text = text.replaceAll("[ ]+", " ");

//        text = text.replaceAll(" H ", " như hình ");
//        text = text.replaceAll("^H ", "như hình ");
//        text = text.replaceAll(" H$", " như hình");

        text = text.replaceAll(" [A-Za-z] ", " ");
        text = text.replaceAll("^[A-Za-z] ", " ");
        text = text.replaceAll(" [A-Za-z]$", " ");

        text = text.replaceAll("步驟[一二三四五六七八九十]", "步驟 ");
        text = text.replaceAll("圖示[一二三四五六七八九十]", "圖示 ");
        text = text.replaceAll("圖片[一二三四五六七八九十]", "圖片 ");
        text = text.replaceAll("圖[一二三四五六七八九十]", "圖 ");

//        text = text.replaceAll("图片 ", " ");
//        text = text.replaceAll("图片$", " ");
//        text = text.replaceAll("圖 ", " ");
//        text = text.replaceAll("圖$", " ");
//        text = text.replaceAll("图 ", " ");
//        text = text.replaceAll("图$", " ");

        text = text.replaceAll(" cm²", " ");
        text = text.replaceAll(" mm", " ");
        text = text.replaceAll(" um", " ");
        text = text.replaceAll(" kgf", " ");
        text = text.replaceAll(" MPa", " ");
        text = text.replaceAll(" KHz", " ");
        text = text.replaceAll(" XXX", " ");
        text = text.replaceAll(" Ø", " ");

        text = text.replaceAll(" +", " ");

        text = text.trim();
        return text;
    }

    private List<String> processMergeText(Map<Integer, String> textMap, List<String> dictionary) {
        List<String> mergedTextList = new ArrayList<>();

        Integer prevRow = -1;
        String prevText = "";
        int langFlag = -2;
        for (Map.Entry<Integer, String> textMapEntry : textMap.entrySet()) {
            Integer row = textMapEntry.getKey();
            String content = textMapEntry.getValue();
            if (dictionary.contains(content)) {
                langFlag = -1;
                prevRow = row;
                continue;
            }

            int countCN = countChineseCharacter(content);
//            int countSpace = countSpaceCharacter(content);
            int countVN = countVietnameseCharacter(content);
//            if (countCN < (content.length() / 2) && countSpace >= (countCN * 2 / 3)) {
            if (countCN > 0 && countVN > 0) {
                if (langFlag != -1 || row - prevRow > 1) {
                    if (!StringUtils.isEmpty(prevText) && (langFlag == 1 || prevText.length() > 5)) {
                        mergedTextList.add(prevText);
                    }
                } else {
                    if (!StringUtils.isEmpty(prevText)) {
                        mergedTextList.add(prevText);
                    }
                }
                prevText = content;
                langFlag = -1;
                prevRow = row;
            } else if (countCN > 0) {
                if (langFlag != 1 || row - prevRow > 1) {
                    if (!StringUtils.isEmpty(prevText) && (langFlag == 1 || prevText.length() > 5)) {
                        mergedTextList.add(prevText);
                    }
                    prevText = content;
                } else {
                    prevText += content;
                }
                langFlag = 1;
                prevRow = row;
            } else if (countVN == 0) {
                if (langFlag != 2 || row - prevRow > 1) {
                    if (!StringUtils.isEmpty(prevText) && (langFlag == 1 || prevText.length() > 5)) {
                        mergedTextList.add(prevText);
                    }
                    prevText = content;
                } else {
                    prevText += " " + content;
                }
                langFlag = 2;
                prevRow = row;
            } else {
                if (langFlag != 0 || row - prevRow > 1) {
                    if (!StringUtils.isEmpty(prevText) && (langFlag == 1 || prevText.length() > 5)) {
                        mergedTextList.add(prevText);
                    }
                    prevText = content;
                } else {
                    prevText += " " + content;
                }
                langFlag = 0;
                prevRow = row;
            }
        }
        if (!StringUtils.isEmpty(prevText) && (langFlag == 1 || prevText.length() > 5)) {
            mergedTextList.add(prevText);
        }

        return mergedTextList;
    }

    private List<Map<String, Object>> processSplitLanguageText(List<String> textList, List<String> dictionary, boolean mergeFlag) {
        List<Map<String, Object>> contentList = new ArrayList<>();

        Map<String, Object> prevMap = new HashMap<>();
        for (String content : textList) {
            content = content.trim();
            if (StringUtils.isEmpty(content)) {
                continue;
            }

            int countCN = countChineseCharacter(content);
//            int countSpace = countSpaceCharacter(content);
            int countVN = countVietnameseCharacter(content);

//            if (countCN < (content.length() / 2) && countSpace >= (countCN * 2 / 3)) {
            if (content.contains("\n")) {
                if (!prevMap.isEmpty()) {
                    contentList.add(prevMap);
                    prevMap = new HashMap<>();
                }

                Map<Integer, String> tmpTextMap = new TreeMap<>();

                List<String> tmpTextList = Arrays.asList(content.split("\n"));
                for (int i = 0; i < tmpTextList.size(); i++) {
                    tmpTextMap.put(i, tmpTextList.get(i));
                }

                List<String> tmpMergedTextList = processMergeText(tmpTextMap, dictionary);
                contentList.addAll(processSplitLanguageText(tmpMergedTextList, dictionary, true));
            } else if (countCN > 0 && countVN > 0) {
                if (!prevMap.isEmpty()) {
                    contentList.add(prevMap);
                    prevMap = new HashMap<>();
                }

                int lastChineseCharacterIndex = lastChineseCharacter(content);

                if (lastChineseCharacterIndex > 0) {
                    prevMap.put("raw", content);
                    prevMap.put("cnText", content.substring(0, lastChineseCharacterIndex).trim());
                    prevMap.put("vnText", content.substring(lastChineseCharacterIndex).trim());

                    if (countChineseCharacter(content.substring(lastChineseCharacterIndex).trim()) == 0) {
                        prevMap.putIfAbsent("checkFlag", 2);
                    } else {
                        prevMap.putIfAbsent("checkFlag", 0);
                    }
                } else {
                    prevMap.put("vnText", content);
                }

                contentList.add(prevMap);
                prevMap = new HashMap<>();
            } else if (countCN > 0) {
                prevMap.put("cnText", content);

                if (!mergeFlag) {
                    contentList.add(prevMap);
                    prevMap = new HashMap<>();
                }
            } else if (countVN == 0) {
                prevMap.put("enText", content);

                if (!mergeFlag) {
                    contentList.add(prevMap);
                    prevMap = new HashMap<>();
                }
            } else {
                prevMap.put("vnText", content);

                contentList.add(prevMap);
                prevMap = new HashMap<>();
            }
        }

        for (Map<String, Object> map : contentList) {
            map.putIfAbsent("checkFlag", !prevMap.isEmpty() ? 1 : 0);
        }
        return contentList;
    }

    private void saveRawText(String file, String sheet, String type, Map<Integer, Map<Integer, String>> textMap) {
        for (Map.Entry<Integer, Map<Integer, String>> textMapEntry : textMap.entrySet()) {
            int col = textMapEntry.getKey();
            for (Map.Entry<Integer, String> rowTextMapEntry : textMapEntry.getValue().entrySet()) {
                int row = rowTextMapEntry.getKey();
                String text = rowTextMapEntry.getValue();

//                log.info("### \"{}\"\t\"{}\"\t\"{}\"\t\"{}\"\t\"{}\"\t\"{}\"", file, sheet, type, col, row, text);
            }
        }
    }

    private void saveText(String file, String sheet, List<Map<String, Object>> contentList) {
        for (Map<String, Object> contentMap : contentList) {
            String cnText = (String) contentMap.getOrDefault("cnText", "");
            String enText = (String) contentMap.getOrDefault("enText", "");
            String vnText = (String) contentMap.getOrDefault("vnText", "");

//            log.info("### \nraw: {}\ncnText: {}\nenText: {}\nvnText: {}", contentMap.get("raw"), contentMap.get("cnText"), contentMap.get("enText"), contentMap.get("vnText"));
//            log.info("### \"{}\"\t\"{}\"\t\"{}\"\t\"{}\"", contentMap.get("raw"), contentMap.get("cnText"), contentMap.get("enText"), contentMap.get("vnText"));
            if (/*(int)contentMap.getOrDefault("checkFlag", 0) == 2 && */
                    (!StringUtils.isEmpty(enText) && !StringUtils.isEmpty(vnText) && enText.split(" ").length >= 5 && vnText.split(" ").length >= 5) ||
                            (!StringUtils.isEmpty(cnText) && !StringUtils.isEmpty(vnText) && cnText.length() >= 5 && vnText.split(" ").length >= 5)) {
//                log.info("### \"{}\"\t\"{}\"\t\"{}\"\t\"{}\"\t\"{}\"\t\"{}\"", cnText, enText, vnText, contentMap.getOrDefault("checkFlag", 0), file, sheet);
                log.info("### \"{}\"\t\"{}\"\t\"{}\"", cnText, enText, vnText);

                TmpText text = new TmpText();
                text.setCnText(cnText);
                text.setEnText(enText);
                text.setVnText(vnText);
                text.setFileName(file);
                text.setSheetName(sheet);
                textRepository.save(text);
            }
        }
    }


    private int countChineseCharacter(String text) {
        int count = 0;

        String regEx = "[\\u4e00-\\u9fa5]";
        Pattern pattern = Pattern.compile(regEx);
        Matcher matcher = pattern.matcher(text);
        while (matcher.find()) {
            int size = matcher.groupCount();
            for (int i = 0; i <= size; i++) {
                count = count + 1;
            }
        }

        return count;
    }

    private int countVietnameseCharacter(String text) {
        int count = 0;

        String VIETNAMESE_DIACRITIC_CHARACTERS
                = "ẮẰẲẴẶĂẤẦẨẪẬÂÁÀÃẢẠĐẾỀỂỄỆÊÉÈẺẼẸÍÌỈĨỊỐỒỔỖỘÔỚỜỞỠỢƠÓÒÕỎỌỨỪỬỮỰƯÚÙỦŨỤÝỲỶỸỴ";
        /*
        for (char c: VIETNAMESE_DIACRITIC_CHARACTERS.toCharArray()) {
            System.out.println(c + ": " + Character.getName(c));
        }
        */

//        String tests[] = new String[3];
//        tests[0] =
//                "Bạn chính là tác giả của Wikipedia!\n" +
//                        "Mọi người đều có thể biên tập bài ngay lập tức, chỉ cần nhớ vài quy tắc." +
//                        "Có sẵn rất nhiều trang trợ giúp như tạo bài, sửa bài hay tải ảnh." +
//                        "Bạn cũng đừng ngại đặt câu hỏi.\n" +
//                        "Hiện chúng ta có 1.109.446 bài viết và 406.782 thành viên.";
//
//        tests[1] =
//                Normalizer.normalize(tests[0], Normalizer.Form.NFD);
//        /*
//        for (char c: tests[1].toCharArray()) {
//            System.out.printf("%04x ", (int) c);
//        }
//        */
//        tests[2] =
//                Normalizer.normalize(tests[0], Normalizer.Form.NFC);

        try {
//            Pattern p = Pattern.compile("(?:[" + VIETNAMESE_DIACRITIC_CHARACTERS + "]|[A-Z])++", Pattern.CANON_EQ | Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE);
            Pattern p = Pattern.compile("(?:[" + VIETNAMESE_DIACRITIC_CHARACTERS + "])++", Pattern.CANON_EQ | Pattern.CASE_INSENSITIVE | Pattern.UNICODE_CASE);

//            for (String t: tests) {
            Matcher m = p.matcher(text);
            while (m.find()) {
//                    System.out.print(m.group() + " ");
//                    log.info("### {}", m.group());
                int size = m.groupCount();
                for (int i = 0; i <= size; i++) {
                    count = count + 1;
                }
            }
//                System.out.println();
//            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return count;
    }

    private int countSpaceCharacter(String text) {
        int count = 0;

        String regEx = "[\\s]";
        Pattern pattern = Pattern.compile(regEx);
        Matcher matcher = pattern.matcher(text);
        while (matcher.find()) {
            int size = matcher.groupCount();
            for (int i = 0; i <= size; i++) {
                count = count + 1;
            }
        }

        return count;
    }

    private int lastChineseCharacter(String text) {
        String lastText = "";
        int lastChineseIndex = -1;

        String regEx = "[\\u4e00-\\u9fa5]";
        Pattern pattern = Pattern.compile(regEx);
        Matcher matcher = pattern.matcher(text);
        while (matcher.find()) {
            int size = matcher.groupCount();
            lastText = matcher.group(size);
            int tmpIndex = text.lastIndexOf(lastText) + lastText.length();
            if (countVietnameseCharacter(text.substring(0, tmpIndex)) > 0) {
                break;
            }
            lastChineseIndex = tmpIndex;
        }

        if (lastChineseIndex != -1) {
            int nextNewLineIndex = text.indexOf("\n", lastChineseIndex);
            int nextSpaceIndex = text.indexOf(" ", lastChineseIndex);
            int nextBreakIndex = Math.min(nextNewLineIndex > 0 ? nextNewLineIndex : text.length(), nextSpaceIndex > 0 ? nextSpaceIndex : text.length());
//            if (nextBreakIndex > 0 && nextBreakIndex - lastChineseIndex < 5) {
            if (nextBreakIndex > 0) {
                if (countVietnameseCharacter(text.substring(lastChineseIndex, nextBreakIndex)) == 0) {
                    return nextBreakIndex;
                }
            }
        }

        return lastChineseIndex;
    }

    private String addSpaceBetweenChineseTextAndNonChineseText(String text) {
        String regEx = "([\\u4e00-\\u9fa5])([^\\u4e00-\\u9fa5])";
        Pattern pattern = Pattern.compile(regEx);
        Matcher matcher = pattern.matcher(text);
        return matcher.replaceAll("$1 $2");
    }

    private String addSpaceBetweenNonChineseTextAndChineseText(String text) {
        String regEx = "([^\\u4e00-\\u9fa5])([\\u4e00-\\u9fa5])";
        Pattern pattern = Pattern.compile(regEx);
        Matcher matcher = pattern.matcher(text);
        return matcher.replaceAll("$1 $2");
    }

}
