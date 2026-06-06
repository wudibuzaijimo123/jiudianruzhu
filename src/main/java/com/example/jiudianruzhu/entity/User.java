package com.example.jiudianruzhu.entity;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class User {
    private Long id;
    private String username;
    private String password;
    private String realName;
    private String phone;
    private String idCard;
    private Integer status;
    private Integer loginErrorCount;
    private LocalDateTime lockTime;
    private LocalDateTime createTime;
    private Integer consumeCount;
}
