package com.foxconn.fii.notify.data;

import lombok.Data;

@Data
public class MailMessage {

    private String title;

    private String body;

    private String[] cc;

    private String[] bcc;

    private String attach;

    private String fileName;

    public static MailMessage of (String title, String body) {
        return of(title, body, null, null, "", "");
    }

    public static MailMessage of (String title, String body, String attach, String fileName) {
        return of(title, body, null, null, attach, fileName);
    }

    public static MailMessage of (String title, String body, String[] cc, String[] bcc, String attach, String fileName) {
        MailMessage result = new MailMessage();
        result.setTitle(title);
        result.setBody(body);
        result.setCc(cc);
        result.setBcc(bcc);
        result.setAttach(attach);
        result.setFileName(fileName);
        return result;
    }
}
