package com.example.jiudianruzhu.controller;

import com.example.jiudianruzhu.entity.BookingOrder;
import com.example.jiudianruzhu.entity.User;
import com.example.jiudianruzhu.service.BookingOrderService;
import com.example.jiudianruzhu.service.RoomTypeService;
import com.example.jiudianruzhu.service.UserService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;

@Controller
public class HomeController {
    @Resource
    private UserService userService;
    @Resource
    private RoomTypeService roomTypeService;
    @Resource
    private BookingOrderService bookingOrderService;

    @GetMapping({"/", "/index", "/rooms"})
    public String rooms(@RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkinDate,
                        @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkoutDate,
                        @RequestParam(required = false) String category,
                        @RequestParam(required = false) String keyword,
                        @RequestParam(required = false) String sort,
                        @RequestParam(required = false) Integer minPrice,
                        @RequestParam(required = false) Integer maxPrice,
                        Model model) {
        LocalDate in = checkinDate == null ? LocalDate.now().plusDays(1) : checkinDate;
        LocalDate out = checkoutDate == null ? in.plusDays(1) : checkoutDate;
        model.addAttribute("checkinDate", in);
        model.addAttribute("checkoutDate", out);
        model.addAttribute("category", category);
        model.addAttribute("keyword", keyword);
        model.addAttribute("sort", sort);
        model.addAttribute("minPrice", minPrice);
        model.addAttribute("maxPrice", maxPrice);
        model.addAttribute("roomTypes", roomTypeService.findAvailable(in, out, category, keyword, sort, minPrice, maxPrice));
        return "user/rooms";
    }

    @GetMapping("/room/detail")
    public String roomDetail(Long id,
                             @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkinDate,
                             @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkoutDate,
                             Model model) {
        model.addAttribute("roomType", roomTypeService.findById(id));
        model.addAttribute("checkinDate", checkinDate);
        model.addAttribute("checkoutDate", checkoutDate);
        return "user/room-detail";
    }

    @GetMapping("/login")
    public String loginPage() {
        return "user/login";
    }

    @PostMapping("/login")
    public String login(String account, String password, HttpSession session, Model model) {
        User user = userService.login(account, password);
        if (user == null) {
            model.addAttribute("msg", "账号、密码错误或账号已被禁用");
            return "user/login";
        }
        session.setAttribute("loginUser", user);
        return "redirect:/rooms";
    }

    @GetMapping("/register")
    public String registerPage() {
        return "user/register";
    }

    @PostMapping("/register")
    public String register(User user, Model model) {
        if (!userService.register(user)) {
            model.addAttribute("msg", "用户名或手机号已存在");
            return "user/register";
        }
        return "redirect:/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/rooms";
    }

    @GetMapping("/profile")
    public String profile(HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        return "user/profile";
    }

    @PostMapping("/profile")
    public String profile(User user, HttpSession session) {
        User loginUser = (User) session.getAttribute("loginUser");
        user.setId(loginUser.getId());
        userService.updateProfile(user);
        loginUser.setRealName(user.getRealName());
        loginUser.setPhone(user.getPhone());
        loginUser.setIdCard(user.getIdCard());
        return "redirect:/profile";
    }

    @GetMapping("/book")
    public String bookPage(Long roomTypeId,
                           @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkinDate,
                           @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkoutDate,
                           Model model) {
        model.addAttribute("roomType", roomTypeService.findById(roomTypeId));
        model.addAttribute("checkinDate", checkinDate);
        model.addAttribute("checkoutDate", checkoutDate);
        return "user/book";
    }

    @PostMapping("/book")
    public String book(BookingOrder order, HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }
        if (!bookingOrderService.create(order, user)) {
            model.addAttribute("msg", "下单失败：库存不足、日期不正确，或该账号在所选时间段已经有有效订单，请更换入住时间。");
            model.addAttribute("roomType", roomTypeService.findById(order.getRoomTypeId()));
            model.addAttribute("checkinDate", order.getCheckinDate());
            model.addAttribute("checkoutDate", order.getCheckoutDate());
            return "user/book";
        }
        return "redirect:/orders";
    }

    @GetMapping("/orders")
    public String orders(HttpSession session, Model model) {
        User user = (User) session.getAttribute("loginUser");
        if (user == null) {
            return "redirect:/login";
        }
        model.addAttribute("orders", bookingOrderService.findByUser(user.getId()));
        return "user/orders";
    }

    @GetMapping("/orders/detail")
    public String orderDetail(Long id, HttpSession session, Model model) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        model.addAttribute("order", bookingOrderService.findById(id));
        return "user/order-detail";
    }

    @GetMapping("/orders/cancel")
    public String cancel(Long id, HttpSession session) {
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/login";
        }
        bookingOrderService.cancel(id);
        return "redirect:/orders";
    }
}
