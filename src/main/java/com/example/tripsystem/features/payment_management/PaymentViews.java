package com.example.tripsystem.features.payment_management;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
@Controller
public class PaymentViews {
    @GetMapping("/create-payment")
    public  String createPayment(){
        return "payment_management/create";
    }

    @GetMapping("/payment-success")
    public  String paymentSuccess(){
        return "payment_management/payment-success";
    }

    @GetMapping("/payments")
    public  String travellerPayments(){
        return "payment_management/traveler_list";
    }

    @GetMapping("/payment-management")
    public  String adminPayments(){
        return "payment_management/admin_list";
    }
}
