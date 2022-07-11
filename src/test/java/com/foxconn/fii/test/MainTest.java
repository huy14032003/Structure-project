package com.foxconn.fii.test;

import lombok.extern.slf4j.Slf4j;
import org.junit.Test;

import java.util.Calendar;
import java.util.Date;

@Slf4j
public class MainTest {

    @Test
    public void mainTest() {
//        StringBuilder sb = new StringBuilder("exxx");
//        sb.append("1");
//        log.info("{}", sb.toString());
//
//        List<PmShortageShippingMode> list = new ArrayList<>();
//        PmShortageShippingMode s = new PmShortageShippingMode();
//        s.setSupplier("1");
//        list.add(s);
//
//        Map<String, PmShortageSchedule.ShippingMode> shippingMap = list
//                .stream().collect(Collectors.toMap(PmShortageShippingMode::getSupplier, PmShortageShippingMode::getShippingMode, (s1, s2) -> s1));

        String commitEta = "2022/05/27*130000;2022/04/29*120000,2022/02/25*70000,2022/01/25*90000,2022/03/25*80000,2021/12/24*90000,2022/06/24*20000";
        String[] commits = commitEta.split("[;,]");
        String commitQtyNumber = "200K";
        commitQtyNumber = commitQtyNumber.substring(0, commitQtyNumber.length() - 1);
        String eta = "2022/02/18";
        boolean flag = eta.length() > 2 && eta.charAt(2) == '/';

        String s = "\"3,2 4-6_\"";
        s = s.replaceAll("[-_\\s\"]", "");

        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MILLISECOND, 0);
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MINUTE, 0);
        calendar.set(Calendar.HOUR_OF_DAY, 0);
        Date now = calendar.getTime();

        log.info("{}", s);
    }

}
