package com.example.tripsystem.features.feedback_management;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class FeedbackViews {
    @GetMapping("/feedback")
    public  String userFeedbacks(){
        return "feedback_management/user_feedback";
    }

    @GetMapping("/feedback-management")
    public  String adminFeedbacks(){
        return "/feedback_management/admin_feedback";
    }
}
