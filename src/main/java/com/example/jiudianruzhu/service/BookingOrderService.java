package com.example.jiudianruzhu.service;

import com.example.jiudianruzhu.entity.BookingOrder;
import com.example.jiudianruzhu.entity.User;

import java.util.List;

public interface BookingOrderService {
    boolean create(BookingOrder order, User user);
    List<BookingOrder> findByUser(Long userId);
    List<BookingOrder> search(String keyword, String status);
    BookingOrder findById(Long id);
    void cancel(Long id);
    boolean checkIn(Long id);
    void checkOut(Long id);
}
