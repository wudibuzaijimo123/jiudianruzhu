package com.example.jiudianruzhu.service.impl;

import com.example.jiudianruzhu.entity.User;
import com.example.jiudianruzhu.mapper.UserMapper;
import com.example.jiudianruzhu.service.UserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper userMapper;

    public User login(String account, String password) {
        User user = userMapper.findByAccount(account);
        if (user == null || user.getStatus() == null || user.getStatus() != 1) {
            return null;
        }
        return user.getPassword().equals(password) ? user : null;
    }

    public User findByAccount(String account) {
        return userMapper.findByAccount(account);
    }

    public boolean register(User user) {
        if (userMapper.findDuplicate(user.getUsername(), user.getPhone()) != null) {
            return false;
        }
        userMapper.insert(user);
        return true;
    }

    public void updateProfile(User user) {
        userMapper.updateProfile(user);
    }

    public void changePassword(Long id, String password) {
        userMapper.updatePassword(id, password);
    }

    public List<User> findAll() {
        return userMapper.findAllWithConsumeCount();
    }

    public void updateStatus(Long id, Integer status) {
        userMapper.updateStatus(id, status);
        if (status != null && status == 1) {
            userMapper.clearLock(id);
        }
    }

    public void updateLoginLock(User user) {
        userMapper.updateLoginLock(user);
    }
}
