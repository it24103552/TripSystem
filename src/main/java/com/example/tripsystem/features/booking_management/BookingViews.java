package com.example.tripsystem.features.booking_management;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class BookingViews {
    @GetMapping("/")
    public String home(){
        return "index";
    }

    @GetMapping("/login")
    public String login(){
        return "login";
    }

    @GetMapping("/register")
    public String register(){
        return "register";
    }

    @GetMapping("/create-booking")
    public  String createBooking(){
        return "booking_management/create";
    }

    @GetMapping("/bookings")
    public  String travellerBookings(){
        return "booking_management/traveler_list";
    }

    @GetMapping("/booking-management")
    public  String adminBookings (){
        return "booking_management/admin_list";
    }


}
