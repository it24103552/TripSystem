package com.example.tripsystem.features.user_management;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserViews {
    @GetMapping("/profile")
    public  String userProfile(){
        return "user_management/profile";
    }

    @GetMapping("/admin-login")
    public  String adminLogin(){
        return "admin_login";
    }

    @GetMapping("/admin-dashboard")
    public  String adminDashoard(){
        return "admin_dashboard";
    }

    @GetMapping("/user-management")
    public  String adminUsers(){
        return "user_management/user-management";
    }
}
