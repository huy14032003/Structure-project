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
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static com.foxconn.fii.config.ApplicationConstant.APPLICATION_NAME_HRM;

@Slf4j
@Service
public class NotifyServiceImpl implements NotifyService {

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private AmqpTemplate amqpTemplate;

    @Autowired
    private ObjectMapper mapper;

    @Value("${server.domains}")
    private String[] domains;

    @Override
    public boolean notifyToMail(NotifyMessage.NotifyType notifyType, String to, MailMessage message) {
        if (StringUtils.isEmpty(to)) {
            return false;
        }
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
        if (StringUtils.isEmpty(to)) {
            return false;
        }
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


    @SuppressWarnings("unchecked")
    @Override
    public boolean getSendMailPermission(String empNo) {
        if ("F1312637".equalsIgnoreCase(empNo)) {
            return false;
        }

        if (StringUtils.isEmpty(APPLICATION_NAME_HRM)) {
            return true;
        }

        String url = "https://hrm.cns.myfiinet.com:8019/jx_api/api/EmailReminder/GetPersonalSetting";

        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
                .queryParam("keywords", empNo);

        ResponseEntity<Map<String, Object>> responseEntity;
        boolean flag = false;
        try {
            responseEntity = restTemplate.exchange(builder.toUriString(), HttpMethod.GET, HttpEntity.EMPTY, new ParameterizedTypeReference<Map<String, Object>>() {});
            if (responseEntity.getStatusCode().is2xxSuccessful() && responseEntity.getBody() != null) {
                List<Map<String, Object>> data = (List<Map<String, Object>>) responseEntity.getBody().getOrDefault("Data", new ArrayList<>());
                for (Map<String, Object> system : data) {
                    if (APPLICATION_NAME_HRM.equalsIgnoreCase((String) system.getOrDefault("sysName", ""))) {
                        List<Map<String, Object>> moduleList = (List<Map<String, Object>>) system.getOrDefault("sysModule", new ArrayList<>());
                        for (Map<String, Object> module : moduleList) {
                            if (APPLICATION_NAME_HRM.equalsIgnoreCase((String) module.getOrDefault("moduleName", ""))) {
                                flag = "Y".equalsIgnoreCase((String) module.getOrDefault("isOpen", ""));
                                break;
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            flag = true;
            log.error("### error", e);
        }

        return flag;
    }
}
