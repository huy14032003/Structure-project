package com.foxconn.fii.notify.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.foxconn.fii.config.ApplicationConstant;
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
    private ObjectMapper mapper;

    @Autowired
    private AmqpTemplate amqpTemplate;

    @Value("${server.domain}")
    private String domain;

    @Override
    public void notifyToMail(MailMessage data, String from, String to) {
        try {
            String json = mapper.writeValueAsString(data);
            String message = mapper.writeValueAsString(NotifyMessage.of(
                    NotifyMessage.System.MAIL,
                    NotifyMessage.Type.TEXT,
                    ApplicationConstant.APPLICATION_NAME,
                    from,
                    to,
                    json));

            amqpTemplate.convertAndSend("notify", "", message);
        } catch (Exception e) {
            log.error("### sendToIcivet error", e);
        }
    }

}
