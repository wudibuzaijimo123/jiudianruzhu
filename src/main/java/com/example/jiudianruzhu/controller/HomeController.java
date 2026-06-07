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
    public String login(String account, String password,
                        @RequestParam(required = false) String redirect,
                        HttpSession session, Model model) {
        User user = userService.findByAccount(account);
        if (user == null) {
            model.addAttribute("msg", "登录失败：该账号不存在");
            return "user/login";
        }
        if (user.getStatus() == null || user.getStatus() != 1) {
            model.addAttribute("msg", "登录失败：该账号已被禁用，请联系管理员");
            return "user/login";
        }

        // 1. Check if user is locked
        java.time.LocalDateTime now = java.time.LocalDateTime.now();
        if (user.getLockTime() != null && now.isBefore(user.getLockTime())) {
            long secondsLeft = java.time.Duration.between(now, user.getLockTime()).getSeconds();
            long minutes = secondsLeft / 60;
            long seconds = secondsLeft % 60;
            String timeMsg = (minutes > 0 ? minutes + " 分钟 " : "") + seconds + " 秒";
            model.addAttribute("msg", "登录失败：该账号已被锁定，请在 " + timeMsg + " 后重试");
            return "user/login";
        }

        // 2. Validate password
        if (!user.getPassword().equals(password)) {
            int errors = user.getLoginErrorCount() == null ? 0 : user.getLoginErrorCount();
            errors++;
            user.setLoginErrorCount(errors);

            if (errors % 5 == 0) {
                // Lock account: duration increases progressively (5 mins, 10 mins, 15 mins...)
                int lockMinutes = (errors / 5) * 5;
                user.setLockTime(now.plusMinutes(lockMinutes));
                userService.updateLoginLock(user);
                model.addAttribute("msg", "登录失败：密码错误。您已连续输错 " + errors + " 次，该账号已被锁定 " + lockMinutes + " 分钟！");
            } else {
                user.setLockTime(null);
                userService.updateLoginLock(user);
                int attemptsLeft = 5 - (errors % 5);
                model.addAttribute("msg", "登录失败：密码错误。您已连续输错 " + errors + " 次，再输错 " + attemptsLeft + " 次账号将被锁定！");
            }
            return "user/login";
        }

        // 3. Success: reset error count and lock time
        user.setLoginErrorCount(0);
        user.setLockTime(null);
        userService.updateLoginLock(user);

        session.setAttribute("loginUser", user);
        if (redirect != null && !redirect.isEmpty()) {
            return "redirect:" + redirect;
        }
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
                           HttpSession session,
                           Model model) {
        if (session.getAttribute("loginUser") == null) {
            String target = "/book?roomTypeId=" + roomTypeId + "&checkinDate=" + checkinDate + "&checkoutDate=" + checkoutDate;
            try {
                target = java.net.URLEncoder.encode(target, "UTF-8");
            } catch (Exception e) {}
            return "redirect:/login?redirect=" + target;
        }
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
            model.addAttribute("msg", "下单失败：库存不足或日期选择不正确，请更换入住时间或选择其他房型。");
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
