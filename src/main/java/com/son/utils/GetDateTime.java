package com.son.utils;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class GetDateTime {
    static DateTimeFormatter format = DateTimeFormatter
            .ofPattern("yyyy-MM-dd");
    public static LocalDateTime now = LocalDateTime.now();

    public static List<String> get7Date() {
        List<String> dateList = new ArrayList<String>();
        for (int i = 6; i >= 0; i--) {
            dateList.add(now.minusDays(i).format(format));
        }
        return dateList;
    }

    public static List<String> getDates(int number) {
        List<String> dateList = new ArrayList<String>();
        for (int i = number-1; i >= 0; i--) {
            dateList.add(now.minusDays(i).format(format));
        }
        return dateList;
    }
}
