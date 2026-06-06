package com.example.jiudianruzhu.entity;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class BookingOrder {
    private Long id;
    private String orderNo;
    private Long userId;
    private Long roomTypeId;
    private Long roomId;
    private String guestName;
    private String guestIdCard;
    private String guestPhone;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkinDate;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkoutDate;
    private Integer nights;
    private BigDecimal totalAmount;
    private String status;
    private LocalDateTime createTime;
    private String username;
    private String userPhone;
    private String typeName;
    private String roomNo;
}
