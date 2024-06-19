package com.foxconn.fii.common.utils;

import com.foxconn.fii.common.model.TimeoutFirewall;
import lombok.experimental.UtilityClass;
import lombok.extern.slf4j.Slf4j;

import java.util.HashMap;
import java.util.Map;

@Slf4j
@UtilityClass
public class FirewallUtils {

    public static final Map<String, TimeoutFirewall> FIREWALL_MAP = new HashMap<>();

    public boolean isAllow(String url) {
        TimeoutFirewall firewall = FIREWALL_MAP.get(url);
        return firewall == null ||
                firewall.getFailCount() < 5 ||
                firewall.getLatestFailTime() == null ||
                System.currentTimeMillis() - firewall.getLatestFailTime().getTime() > 5 * 60 * 1000;
    }

    public void increaseFail(String url) {
        TimeoutFirewall firewall = FIREWALL_MAP.getOrDefault(url, new TimeoutFirewall(url));
        firewall.increaseFail();
        FIREWALL_MAP.put(url, firewall);
        log.debug("### increaseFail {} {}", url, firewall.getFailCount());
    }

    public void resetFail(String url) {
        FIREWALL_MAP.remove(url);
    }

}
