package com.example.jiudianruzhu.controller;

import com.example.jiudianruzhu.entity.Admin;
import com.example.jiudianruzhu.entity.Room;
import com.example.jiudianruzhu.entity.RoomType;
import com.example.jiudianruzhu.service.*;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Resource
    private AdminService adminService;
    @Resource
    private RoomTypeService roomTypeService;
    @Resource
    private RoomService roomService;
    @Resource
    private BookingOrderService bookingOrderService;
    @Resource
    private UserService userService;

    @GetMapping("/login")
    public String loginPage() {
        return "admin/login";
    }

    @PostMapping("/login")
    public String login(String username, String password, HttpSession session, Model model) {
        Admin admin = adminService.login(username, password);
        if (admin == null) {
            model.addAttribute("msg", "管理员账号或密码错误");
            return "admin/login";
        }
        session.setAttribute("loginAdmin", admin);
        return "redirect:/admin/orders";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("loginAdmin");
        return "redirect:/admin/login";
    }

    @GetMapping("/roomTypes")
    public String roomTypes(Model model) {
        model.addAttribute("roomTypes", roomTypeService.findAll());
        return "admin/room-types";
    }

    @PostMapping("/roomTypes/save")
    public String saveRoomType(RoomType roomType) {
        if (roomType.getStatus() == null) {
            roomType.setStatus(1);
        }
        roomTypeService.save(roomType);
        return "redirect:/admin/roomTypes";
    }

    @GetMapping("/roomTypes/delete")
    public String deleteRoomType(Long id) {
        roomTypeService.delete(id);
        return "redirect:/admin/roomTypes";
    }

    @GetMapping("/roomTypes/status")
    public String roomTypeStatus(Long id, Integer status) {
        roomTypeService.updateStatus(id, status);
        return "redirect:/admin/roomTypes";
    }

    @GetMapping("/rooms")
    public String rooms(Model model) {
        model.addAttribute("rooms", roomService.findAll());
        model.addAttribute("roomTypes", roomTypeService.findAll());
        return "admin/rooms";
    }

    @PostMapping("/rooms/save")
    public String saveRoom(Room room) {
        if (room.getStatus() == null || room.getStatus().isEmpty()) {
            room.setStatus("FREE");
        }
        roomService.save(room);
        return "redirect:/admin/rooms";
    }

    @GetMapping("/rooms/delete")
    public String deleteRoom(Long id) {
        roomService.delete(id);
        return "redirect:/admin/rooms";
    }

    @GetMapping("/rooms/status")
    public String roomStatus(Long id, String status) {
        roomService.updateStatus(id, status);
        return "redirect:/admin/rooms";
    }

    @GetMapping("/orders")
    public String orders(String keyword, String status, Model model) {
        model.addAttribute("orders", bookingOrderService.search(keyword, status));
        model.addAttribute("keyword", keyword);
        model.addAttribute("status", status);
        return "admin/orders";
    }

    @GetMapping("/orders/checkin")
    public String checkIn(Long id) {
        bookingOrderService.checkIn(id);
        return "redirect:/admin/orders";
    }

    @GetMapping("/orders/checkout")
    public String checkOut(Long id) {
        bookingOrderService.checkOut(id);
        return "redirect:/admin/orders";
    }

    @GetMapping("/orders/cancel")
    public String cancel(Long id) {
        bookingOrderService.cancel(id);
        return "redirect:/admin/orders";
    }

    @GetMapping("/users")
    public String users(Model model) {
        model.addAttribute("users", userService.findAll());
        return "admin/users";
    }

    @GetMapping("/users/status")
    public String userStatus(Long id, Integer status) {
        userService.updateStatus(id, status);
        return "redirect:/admin/users";
    }
}
