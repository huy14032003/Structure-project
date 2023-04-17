package com.foxconn.fii.notify.data;

import lombok.Data;

@Data
public class NotifyMessage {

    private System system;

    private MessageType type;

    private String source;

    private NotifyType notifyType = NotifyType.NOTICE;

    private String from;

    private String toUser;

    private String message;


    public static NotifyMessage of(System system, MessageType type, String source, NotifyType notifyType, String from, String toUser, String message) {
        NotifyMessage notifyMessage = new NotifyMessage();
        notifyMessage.setSystem(system);
        notifyMessage.setType(type);
        notifyMessage.setSource(source);
        notifyMessage.setNotifyType(notifyType);
        notifyMessage.setFrom(from);
        notifyMessage.setToUser(toUser);
        notifyMessage.setMessage(message);
        return notifyMessage;
    }

    public enum System {
        HALO,
        FII_CHAT,
        CIVET,
        MAIL,
        FII_VN
    }

    public enum MessageType {
        TEXT,
        IMAGE,
        FILE,
        NEWS
    }

    public enum NotifyType {
        APPROVAL,
        NOTICE,
        HIGHLIGHT
    }

}
