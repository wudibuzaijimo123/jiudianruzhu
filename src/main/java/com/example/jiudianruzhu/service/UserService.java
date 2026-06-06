package com.example.jiudianruzhu.service;

import com.example.jiudianruzhu.entity.User;

import java.util.List;

public interface UserService {
    User login(String account, String password);
    User findByAccount(String account);
    boolean register(User user);
    void updateProfile(User user);
    void changePassword(Long id, String password);
    List<User> findAll();
    void updateStatus(Long id, Integer status);
    void updateLoginLock(User user);
}
