package com.example.jiudianruzhu.entity;

import lombok.Data;

@Data
public class Room {
    private Long id;
    private Long roomTypeId;
    private String roomNo;
    private String floorNo;
    private String status;
    private String typeName;
}
