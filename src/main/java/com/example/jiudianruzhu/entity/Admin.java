package com.example.jiudianruzhu.entity;

import lombok.Data;

@Data
public class Admin {
    private Long id;
    private String username;
    private String password;
    private String realName;
    private Integer status;
}
