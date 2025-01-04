package com.foxconn.fii.common.utils;

import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.PDFRenderer;
import org.springframework.util.StringUtils;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


@Slf4j
@UtilityClass
public class PdfUtils {

    public static List<String> convertPdfToImage(File pdfFile, String imageFolderPath, String pages) {
        List<String> imageList = new ArrayList<>();

        PDDocument document;
        try {
            document = PDDocument.load(pdfFile);
        } catch (Exception e) {
            log.error("### Hệ thống không thể đọc file này {}", pdfFile.getPath());
            return imageList;
        }

        List<String> pageList = new ArrayList<>();
        if (!StringUtils.isEmpty(pages)) {
            pageList = Arrays.asList(pages.split(","));
        }

        PDFRenderer pdfRenderer = new PDFRenderer(document);
        try {
            for (int i = 0; i < document.getNumberOfPages(); i++) {
                if (!pageList.isEmpty() && !pageList.contains(String.valueOf(i))) {
                    continue;
                }

                String imageName = pdfFile.getName() + (i == 0 ? "" : "(" + i + ")") + ".jpeg";

                File image = new File(imageFolderPath + "/" + imageName);

                BufferedImage bufferedImage = pdfRenderer.renderImageWithDPI(i, 500, org.apache.pdfbox.rendering.ImageType.RGB);
//                addLicenceFII(bufferedImage);

                Rectangle boundingBox = detectBoundingBox(bufferedImage);
                if (boundingBox != null) {
                    BufferedImage croppedImage = bufferedImage.getSubimage(boundingBox.x, boundingBox.y, boundingBox.width, boundingBox.height);
                    ImageIO.write(croppedImage, "jpeg", image);
                } else {
                    ImageIO.write(bufferedImage, "jpeg", image);
                }

                if (image.length() > 0) {
//                    generateThumbnail(image);
                    imageList.add(imageName);
                }
            }
        } catch (Exception e) {
            log.error("### Chuyển đổi sang ảnh gặp vấn đề {}", pdfFile.getPath(), e);
        }

        try {
            document.close();
        } catch (IOException ignored) {
        }

        return imageList;
    }

    public static void generateThumbnail(File image) {
        if (!image.exists()) {
            return;
        }

        try {
            String fileParent = image.getParent();
            String fileName = image.getName();
            String thumbnailPath = fileParent + "/" + "thumbnail_" + fileName;
            BufferedImage thumb = ImageIO.read(image);
            BufferedImage resized = resize(thumb);
            File thumbnail = new File(thumbnailPath);
            ImageIO.write(resized, "png", thumbnail);
        } catch (IOException e) {
            log.error("### generate thumbnail error", e);
        }
    }

    public static BufferedImage resize(BufferedImage img) {
        Image tmp = img.getScaledInstance(900, 600, Image.SCALE_SMOOTH);
        BufferedImage resized = new BufferedImage(900, 600, BufferedImage.TYPE_INT_ARGB);
        Graphics2D g2d = resized.createGraphics();
        g2d.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);
        g2d.drawImage(tmp, 0, 0, null);
        g2d.dispose();
        return resized;
    }

    public static void addLicenceFII(BufferedImage bImage){
        Graphics g = bImage.getGraphics();
        g.setColor(Color.RED);
        g.setFont(new Font("TimesRoman", Font.BOLD, 60));
        g.drawString("Copyright FII 2024", 30, 80);
        g.dispose();
    }

    public static Rectangle detectBoundingBox(BufferedImage img) {
        int width = img.getWidth();
        int height = img.getHeight();

        int xMin = width, yMin = height;
        int xMax = 0, yMax = 0;

        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                int pixel = img.getRGB(x, y);

                Color color = new Color(pixel, true);
                if (!isWhite(color)) {
                    xMin = Math.min(xMin, x);
                    yMin = Math.min(yMin, y);
                    xMax = Math.max(xMax, x);
                    yMax = Math.max(yMax, y);
                }
            }
        }

        if (xMin > xMax || yMin > yMax) {
            return null;
        }

        return new Rectangle(xMin, yMin, xMax-xMin, yMax-yMin);
    }

    public boolean isWhite(Color color) {
        int tolerance = 5;
        return color.getRed() >= 255 - tolerance &&
                color.getGreen() >= 255 - tolerance &&
                color.getBlue() >= 255 - tolerance;
    }
}
