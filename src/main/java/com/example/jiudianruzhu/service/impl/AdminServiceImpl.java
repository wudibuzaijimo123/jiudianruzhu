package com.example.jiudianruzhu.service.impl;

import com.example.jiudianruzhu.entity.Admin;
import com.example.jiudianruzhu.mapper.AdminMapper;
import com.example.jiudianruzhu.service.AdminService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service
public class AdminServiceImpl implements AdminService {
    @Resource
    private AdminMapper adminMapper;

    public Admin login(String username, String password) {
        Admin admin = adminMapper.findByUsername(username);
        return admin != null && admin.getPassword().equals(password) ? admin : null;
    }
}
