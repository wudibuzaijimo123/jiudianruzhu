package com.example.jiudianruzhu.service.impl;

import com.example.jiudianruzhu.entity.BookingOrder;
import com.example.jiudianruzhu.entity.Room;
import com.example.jiudianruzhu.entity.RoomType;
import com.example.jiudianruzhu.entity.User;
import com.example.jiudianruzhu.mapper.BookingOrderMapper;
import com.example.jiudianruzhu.mapper.RoomMapper;
import com.example.jiudianruzhu.mapper.RoomTypeMapper;
import com.example.jiudianruzhu.service.BookingOrderService;
import com.example.jiudianruzhu.util.OrderNoUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.time.temporal.ChronoUnit;
import java.util.List;

@Service
public class BookingOrderServiceImpl implements BookingOrderService {
    @Resource
    private BookingOrderMapper bookingOrderMapper;
    @Resource
    private RoomMapper roomMapper;
    @Resource
    private RoomTypeMapper roomTypeMapper;

    @Transactional
    public boolean create(BookingOrder order, User user) {
        int nights = (int) ChronoUnit.DAYS.between(order.getCheckinDate(), order.getCheckoutDate());
        if (nights <= 0) {
            return false;
        }
        order.setUserId(user.getId());
        if (bookingOrderMapper.countUserConflict(order) > 0) {
            return false;
        }
        Room room = roomMapper.findAvailable(order.getRoomTypeId(), order.getCheckinDate(), order.getCheckoutDate());
        if (room == null) {
            return false;
        }
        RoomType roomType = roomTypeMapper.findById(order.getRoomTypeId());
        order.setOrderNo(OrderNoUtil.next());
        order.setRoomId(room.getId());
        order.setNights(nights);
        order.setTotalAmount(roomType.getPrice().multiply(new java.math.BigDecimal(nights)));
        order.setStatus("BOOKED");
        bookingOrderMapper.insert(order);
        return true;
    }

    public List<BookingOrder> findByUser(Long userId) {
        return bookingOrderMapper.findByUser(userId);
    }

    public List<BookingOrder> search(String keyword, String status) {
        return bookingOrderMapper.search(keyword, status);
    }

    public BookingOrder findById(Long id) {
        return bookingOrderMapper.findById(id);
    }

    public void cancel(Long id) {
        bookingOrderMapper.updateStatus(id, "CANCELED");
    }

    @Transactional
    public boolean checkIn(Long id) {
        BookingOrder order = bookingOrderMapper.findById(id);
        if (order == null || !"BOOKED".equals(order.getStatus())) {
            return false;
        }
        Room room = roomMapper.findAvailable(order.getRoomTypeId(), order.getCheckinDate(), order.getCheckoutDate());
        if (room == null) {
            return false;
        }
        bookingOrderMapper.checkIn(id, room.getId());
        roomMapper.updateStatus(room.getId(), "OCCUPIED");
        return true;
    }

    @Transactional
    public void checkOut(Long id) {
        BookingOrder order = bookingOrderMapper.findById(id);
        bookingOrderMapper.updateStatus(id, "COMPLETED");
        if (order != null && order.getRoomId() != null) {
            roomMapper.updateStatus(order.getRoomId(), "CLEANING");
        }
    }
}
