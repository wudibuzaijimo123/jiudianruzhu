package com.example.jiudianruzhu.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
public class RoomType {
    private Long id;
    private String typeName;
    private String category;
    private String imageUrl;
    private BigDecimal price;
    private BigDecimal originalPrice;
    private String starLevel;
    private BigDecimal rating;
    private String distanceText;
    private String bedType;
    private Integer capacity;
    private String breakfast;
    private String facilities;
    private String tags;
    private String promotion;
    private String description;
    private Integer status;
    private LocalDateTime createTime;
    private Integer availableCount;
}
