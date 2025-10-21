package com.example.tripsystem.features.feedback_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/feedbacks")
public class FeedbackController {

    @Autowired
    private FeedbackService feedbackService;

    @PostMapping
    public ResponseEntity<?> createFeedback(@RequestBody FeedbackDTOS.CreateFeedbackRequest request) {
        try {
            FeedbackDTOS.FeedbackResponse response = feedbackService.createFeedback(request);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error creating feedback: " + e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getFeedbackById(@PathVariable Long id) {
        try {
            Optional<FeedbackDTOS.FeedbackResponse> feedback = feedbackService.getFeedbackById(id);
            if (feedback.isPresent()) {
                return ResponseEntity.ok(feedback.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Feedback not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving feedback: " + e.getMessage());
        }
    }

    @GetMapping
    public ResponseEntity<?> getAllFeedbacks() {
        try {
            List<FeedbackDTOS.FeedbackResponse> feedbacks = feedbackService.getAllFeedbacks();
            return ResponseEntity.ok(feedbacks);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving feedbacks: " + e.getMessage());
        }
    }

    @GetMapping("/active")
    public ResponseEntity<?> getActiveFeedbacks() {
        try {
            List<FeedbackDTOS.FeedbackResponse> feedbacks = feedbackService.getActiveFeedbacks();
            return ResponseEntity.ok(feedbacks);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving active feedbacks: " + e.getMessage());
        }
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<?> getFeedbacksByUserId(@PathVariable Long userId) {
        try {
            List<FeedbackDTOS.FeedbackResponse> feedbacks = feedbackService.getFeedbacksByUserId(userId);
            return ResponseEntity.ok(feedbacks);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving user feedbacks: " + e.getMessage());
        }
    }

    @GetMapping("/user/{userId}/active")
    public ResponseEntity<?> getActiveFeedbacksByUserId(@PathVariable Long userId) {
        try {
            List<FeedbackDTOS.FeedbackResponse> feedbacks = feedbackService.getActiveFeedbacksByUserId(userId);
            return ResponseEntity.ok(feedbacks);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving active user feedbacks: " + e.getMessage());
        }
    }

    @GetMapping("/stars/{numOfStars}")
    public ResponseEntity<?> getFeedbacksByStars(@PathVariable Integer numOfStars) {
        try {
            List<FeedbackDTOS.FeedbackResponse> feedbacks = feedbackService.getFeedbacksByStars(numOfStars);
            return ResponseEntity.ok(feedbacks);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving feedbacks by stars: " + e.getMessage());
        }
    }

    @GetMapping("/min-stars/{minStars}")
    public ResponseEntity<?> getFeedbacksByMinStars(@PathVariable Integer minStars) {
        try {
            List<FeedbackDTOS.FeedbackResponse> feedbacks = feedbackService.getFeedbacksByMinStars(minStars);
            return ResponseEntity.ok(feedbacks);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving feedbacks by minimum stars: " + e.getMessage());
        }
    }

    @GetMapping("/recent")
    public ResponseEntity<?> getRecentFeedbacks() {
        try {
            List<FeedbackDTOS.FeedbackResponse> feedbacks = feedbackService.getRecentFeedbacks();
            return ResponseEntity.ok(feedbacks);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving recent feedbacks: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateFeedback(@PathVariable Long id, @RequestBody FeedbackDTOS.UpdateFeedbackRequest request) {
        try {
            Optional<FeedbackDTOS.FeedbackResponse> updatedFeedback = feedbackService.updateFeedback(id, request);
            if (updatedFeedback.isPresent()) {
                return ResponseEntity.ok(updatedFeedback.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Feedback not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating feedback: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteFeedback(@PathVariable Long id) {
        try {
            boolean deleted = feedbackService.deleteFeedback(id);
            if (deleted) {
                return ResponseEntity.ok("Feedback deleted successfully");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Feedback not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error deleting feedback: " + e.getMessage());
        }
    }
}