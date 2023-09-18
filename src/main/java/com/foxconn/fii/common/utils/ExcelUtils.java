package com.foxconn.fii.common.utils;

import com.foxconn.fii.common.exception.CommonException;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellAddress;
import org.apache.poi.ss.util.CellRangeAddress;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;

@Slf4j
@UtilityClass
public class ExcelUtils {

    public String getStringValue(Cell cell) {
        if (cell == null) {
            return "";
        }

        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue().replaceAll(" ", " ").trim();
            case NUMERIC:
                if (HSSFDateUtil.isCellDateFormatted(cell)) {
                    SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    return df.format(cell.getDateCellValue());
                } else {
                    double number = cell.getNumericCellValue();
                    BigDecimal bd = BigDecimal.valueOf(number);
                    String numberString = bd.toPlainString();
                    if (numberString.endsWith(".0")) {
                        numberString = numberString.replace(".0", "");
                    }
                    return numberString;
                }
            case FORMULA:
                log.debug("### getStringValue error - formula {} - {}", cell.getAddress(), cell.getCellFormula());
                return "";
            case ERROR:
                log.debug("### getStringValue error - error {} - {}", cell.getAddress(), FormulaError.forInt(cell.getErrorCellValue()).getString());
                return "";
            case BLANK:
                return "";
            default:
                log.info("### getStringValue error - default {} - {}", cell.getAddress(), cell.getCellType());
                return "";
        }
    }

    public String getStringValue(Cell cell, String datePattern) {
        if (cell == null) {
            return "";
        }

        switch (cell.getCellType()) {
            case STRING:
                return cell.getStringCellValue();
            case NUMERIC:
                if (HSSFDateUtil.isCellDateFormatted(cell)) {
                    SimpleDateFormat df = new SimpleDateFormat(datePattern);
                    return df.format(cell.getDateCellValue());
                } else {
                    double number = cell.getNumericCellValue();
                    BigDecimal bd = BigDecimal.valueOf(number);
                    return bd.toPlainString();
                }
            case FORMULA:
//                log.debug("### getStringValue error - formula {} - {}", cell.getAddress(), cell.getCellFormula());
                return "";
            case ERROR:
//                log.debug("### getStringValue error - error {} - {}", cell.getAddress(), FormulaError.forInt(cell.getErrorCellValue()).getString());
                return "";
            default:
//                log.info("### getStringValue error - default {} - {}", cell.getAddress(), cell.getCellType());
                return "";
        }
    }

    public Double getDoubleValue(Cell cell) {
            if (cell == null) {
                return 0D;
            }

            switch (cell.getCellType()) {
                case NUMERIC:
                    return cell.getNumericCellValue();
                case STRING:
                    try {
                        return Double.parseDouble(cell.getStringCellValue());
                    } catch (Exception e) {
                        throw CommonException.of("Cell {} is invalid format double number", cell.getAddress());
                    }
                case BLANK:
                    return 0d;
                default:
                    throw CommonException.of("Cell {} is invalid format double number", cell.getAddress());
            }
    }

    public Integer getIntegerValue(Cell cell) {
        if (cell == null) {
            return 0;
        }

        switch (cell.getCellType()) {
            case NUMERIC:
                return (int)cell.getNumericCellValue();
            case STRING:
                try {
                    return Integer.parseInt(cell.getStringCellValue());
                } catch (Exception e) {
                    throw CommonException.of("Cell {} is invalid format int number", cell.getAddress());
                }
            case BLANK:
                return 0;
            default:
                throw CommonException.of("Cell {} is invalid format int number", cell.getAddress());
        }
    }

    public Double getDateExcelValue(Cell cell, String pattern) {
        if (cell == null) {
            return null;
        }

        SimpleDateFormat df = new SimpleDateFormat(pattern);

        switch (cell.getCellType()) {
            case NUMERIC:
                return cell.getNumericCellValue();
            case STRING:
                try {
                    return DateUtil.getExcelDate(df.parse(cell.getStringCellValue()));
                } catch (ParseException e) {
                    log.error("### getDateValue format error {}", cell.getStringCellValue());
                    throw CommonException.of("Cell {} is invalid format date {}", cell.getAddress(), pattern);
                }
            case BLANK:
                return null;
            default:
                throw CommonException.of("Cell {} is invalid format date {}", cell.getAddress(), pattern);
        }
    }

    public Date getDateValue(Cell cell, String... patterns) {
        if (cell == null) {
            return null;
        }

        switch (cell.getCellType()) {
            case NUMERIC:
                return DateUtil.getJavaDate(cell.getNumericCellValue());
            case STRING:
                for (String pattern : patterns) {
                    try {
                        SimpleDateFormat df = new SimpleDateFormat(pattern);
                        df.setLenient(false);
                        return df.parse(cell.getStringCellValue());
                    } catch (ParseException ignored) {}
                }

                log.error("### getDateValue format error {}", cell.getStringCellValue());
                throw CommonException.of("Cell {} is invalid format date {}", cell.getAddress(), Arrays.toString(patterns));
            case BLANK:
                return null;
            default:
                throw CommonException.of("Cell {} is invalid format date {}", cell.getAddress(), Arrays.toString(patterns));
        }
    }

    public void copyRow(Sheet oldSheet, Sheet newSheet, int irStartOldSheet, int irStartNewSheet, int numberRow) {
        for (int i = 0; i < numberRow; i++) {
            Row row = oldSheet.getRow(irStartOldSheet + i);
            if (row == null) {
                continue;
            }

            for(Cell oldCell : row) {
                if (newSheet.getRow(irStartNewSheet + i) == null) {
                    newSheet.createRow(irStartNewSheet + i);
                }

                newSheet.setColumnWidth(oldCell.getColumnIndex(), oldSheet.getColumnWidth(oldCell.getColumnIndex()));

                CellStyle ollStyle = oldCell.getCellStyle();
                Cell newCell = newSheet.getRow(irStartNewSheet + i).createCell(oldCell.getColumnIndex());
                newCell.setCellStyle(ollStyle);
                switch (oldCell.getCellType()) {
                    case STRING:
                        newCell.setCellValue(oldCell.getRichStringCellValue());
                        break;
                    case NUMERIC:
                        newCell.setCellValue(oldCell.getNumericCellValue());
                        break;
                    case BOOLEAN:
                        newCell.setCellValue(oldCell.getBooleanCellValue());
                        break;
                    case FORMULA:
                        String oldFormula = oldCell.getCellFormula();
                        String[] cellAddresses = oldFormula.split("[+\\-\\*\\/]");
                        for (String cellAddress : cellAddresses) {
                            CellAddress oldCellAddress = new CellAddress(cellAddress);
                            CellAddress newCellAddress = new CellAddress(newCell.getRowIndex() + oldCellAddress.getRow() - oldCell.getRowIndex(), oldCellAddress.getColumn());
                            oldFormula = oldFormula.replace(cellAddress, newCellAddress.formatAsString());
                        }
                        newCell.setCellFormula(oldFormula);
                        break;
                    case BLANK:
                        newCell.setBlank();
                        break;
                    case ERROR:
                        newCell.setCellErrorValue(oldCell.getErrorCellValue());
                        break;
                }
            }
        }

        for (CellRangeAddress cellRangeAddress : oldSheet.getMergedRegions()) {
            if (irStartOldSheet <= cellRangeAddress.getFirstRow() && irStartOldSheet + numberRow > cellRangeAddress.getLastRow()) {
                newSheet.addMergedRegion(new CellRangeAddress(irStartNewSheet + cellRangeAddress.getFirstRow() - irStartOldSheet, irStartNewSheet + cellRangeAddress.getLastRow() - irStartOldSheet, cellRangeAddress.getFirstColumn(), cellRangeAddress.getLastColumn()));
            }
        }
    }

    public static CellStyle createStyleForHeader(Sheet sheet) {
        // Create font
        Font font = sheet.getWorkbook().createFont();
        font.setFontName("Times New Roman");
        font.setBold(false);
        font.setFontHeightInPoints((short) 14); // font size
        font.setColor(IndexedColors.WHITE.getIndex()); // text color

        // Create CellStyle
        CellStyle cellStyle = sheet.getWorkbook().createCellStyle();
        cellStyle.setFont(font);
        cellStyle.setAlignment(HorizontalAlignment.CENTER);
        cellStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
        cellStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        cellStyle.setBorderBottom(BorderStyle.THIN);
        cellStyle.setBorderRight(BorderStyle.THIN);
        return cellStyle;
    }
}
