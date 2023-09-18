package com.foxconn.fii.notify.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foxconn.fii.config.ApplicationConstant;
import com.foxconn.fii.notify.data.IcivetTextMessage;
import com.foxconn.fii.notify.data.MailMessage;
import com.foxconn.fii.notify.data.NotifyMessage;
import com.foxconn.fii.notify.service.NotifyService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Slf4j
@Service
public class NotifyServiceImpl implements NotifyService {

    @Autowired
    private AmqpTemplate amqpTemplate;

    @Autowired
    private ObjectMapper mapper;

    @Value("${server.domains}")
    private String[] domains;

    @Override
    public boolean notifyToMail(NotifyMessage.NotifyType notifyType, String to, MailMessage message) {
        try {
            String json = mapper.writeValueAsString(message);
            String notifyMessage = mapper.writeValueAsString(NotifyMessage.of(
                    NotifyMessage.System.MAIL,
                    NotifyMessage.MessageType.TEXT,
                    ApplicationConstant.APPLICATION_NAME,
                    notifyType,
                    "",
                    to,
                    json));
            amqpTemplate.convertAndSend("notify", "", notifyMessage);
            return true;
        } catch (Exception e) {
            log.error("### notifyToMail error", e);
            return false;
        }
    }

    @Override
    public boolean notifyToIcivet(NotifyMessage.NotifyType notifyType, String to, IcivetTextMessage message) {
        try {
            String json = mapper.writeValueAsString(message);
            String notifyMessage = mapper.writeValueAsString(NotifyMessage.of(
                    NotifyMessage.System.CIVET,
                    NotifyMessage.MessageType.TEXT,
                    ApplicationConstant.APPLICATION_NAME,
                    notifyType,
                    "",
                    to,
                    json));
            amqpTemplate.convertAndSend("notify", "", notifyMessage);
            return true;
        } catch (Exception e) {
            log.error("### notifyToIcivet error", e);
            return false;
        }
    }
}
