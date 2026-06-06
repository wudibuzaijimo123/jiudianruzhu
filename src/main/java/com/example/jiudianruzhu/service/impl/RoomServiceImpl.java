package com.example.jiudianruzhu.service.impl;

import com.example.jiudianruzhu.entity.Room;
import com.example.jiudianruzhu.mapper.RoomMapper;
import com.example.jiudianruzhu.service.RoomService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class RoomServiceImpl implements RoomService {
    @Resource
    private RoomMapper roomMapper;

    public List<Room> findAll() {
        return roomMapper.findAll();
    }

    public void save(Room room) {
        if (room.getId() == null) {
            roomMapper.insert(room);
        } else {
            roomMapper.update(room);
        }
    }

    public void delete(Long id) {
        roomMapper.delete(id);
    }

    public void updateStatus(Long id, String status) {
        roomMapper.updateStatus(id, status);
    }
}
