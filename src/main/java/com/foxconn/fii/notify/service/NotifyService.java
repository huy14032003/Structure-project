package com.foxconn.fii.notify.service;

import com.foxconn.fii.notify.data.MailMessage;
import com.foxconn.fii.notify.data.NotifyMessage;

public interface NotifyService {

    boolean notifyToMail(NotifyMessage.NotifyType notifyType, String to, MailMessage message);
}
