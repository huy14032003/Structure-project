package com.foxconn.fii.common.model;

import lombok.Data;

import java.util.Date;

@Data
public class TimeoutFirewall {
    private String url;

    private int failCount;

    private Date latestFailTime;

    public TimeoutFirewall(String url) {
        this.url = url;
    }

    public void increaseFail() {
        failCount++;
        latestFailTime = new Date();
    }
}
