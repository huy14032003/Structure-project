package com.foxconn.fii.notify.service;

import com.foxconn.fii.notify.data.IcivetTextMessage;
import com.foxconn.fii.notify.data.MailMessage;
import com.foxconn.fii.notify.data.NotifyMessage;

public interface NotifyService {

    boolean notifyToMail(NotifyMessage.NotifyType notifyType, String to, MailMessage message);

    boolean notifyToIcivet(NotifyMessage.NotifyType notifyType, String to, IcivetTextMessage message);

    boolean getSendMailPermission(String empNo);
}
