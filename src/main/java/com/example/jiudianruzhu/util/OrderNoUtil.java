package com.example.jiudianruzhu.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.concurrent.ThreadLocalRandom;

public final class OrderNoUtil {
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");

    private OrderNoUtil() {
    }

    public static String next() {
        return "JD" + LocalDateTime.now().format(FORMATTER)
                + ThreadLocalRandom.current().nextInt(1000, 9999);
    }
}
