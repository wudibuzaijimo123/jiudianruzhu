package com.example.jiudianruzhu.service.impl;

import com.example.jiudianruzhu.entity.RoomType;
import com.example.jiudianruzhu.mapper.RoomTypeMapper;
import com.example.jiudianruzhu.service.RoomTypeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.util.List;

@Service
public class RoomTypeServiceImpl implements RoomTypeService {
    @Resource
    private RoomTypeMapper roomTypeMapper;

    public List<RoomType> findAll() {
        return roomTypeMapper.findAll();
    }

    public List<RoomType> findAvailable(LocalDate checkinDate, LocalDate checkoutDate, String category, String keyword, String sort, Integer minPrice, Integer maxPrice) {
        List<RoomType> list = roomTypeMapper.findOnline(category, keyword, sort, minPrice, maxPrice);
        for (RoomType roomType : list) {
            roomType.setAvailableCount(roomTypeMapper.countAvailable(roomType.getId(), checkinDate, checkoutDate));
        }
        return list;
    }

    public RoomType findById(Long id) {
        return roomTypeMapper.findById(id);
    }

    public void save(RoomType roomType) {
        if (roomType.getId() == null) {
            roomTypeMapper.insert(roomType);
        } else {
            roomTypeMapper.update(roomType);
        }
    }

    public void delete(Long id) {
        roomTypeMapper.delete(id);
    }

    public void updateStatus(Long id, Integer status) {
        roomTypeMapper.updateStatus(id, status);
    }
}
