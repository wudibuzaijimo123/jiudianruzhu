package com.example.jiudianruzhu.service;

import com.example.jiudianruzhu.entity.Room;

import java.util.List;

public interface RoomService {
    List<Room> findAll();
    void save(Room room);
    void delete(Long id);
    void updateStatus(Long id, String status);
}
