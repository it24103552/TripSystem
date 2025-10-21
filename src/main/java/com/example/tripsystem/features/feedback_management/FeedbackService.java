package com.example.tripsystem.features.feedback_management;

import com.example.tripsystem.features.user_management.UserModel;
import com.example.tripsystem.features.user_management.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class FeedbackService {

    @Autowired
    private FeedbackRepository feedbackRepository;

    @Autowired
    private UserRepository userRepository;

    public FeedbackDTOS.FeedbackResponse createFeedback(FeedbackDTOS.CreateFeedbackRequest request) {
        UserModel user = userRepository.findById(request.getUserId()).orElseThrow();

        FeedbackModel feedback = new FeedbackModel(
                request.getTitle(),
                request.getSubTitle(),
                request.getDeleteStatus(),
                LocalDateTime.now(),
                request.getNumOfStars(),
                user
        );

        FeedbackModel savedFeedback = feedbackRepository.save(feedback);
        return convertToFeedbackResponse(savedFeedback);
    }

    public Optional<FeedbackDTOS.FeedbackResponse> getFeedbackById(Long id) {
        return feedbackRepository.findById(id).map(this::convertToFeedbackResponse);
    }

    public List<FeedbackDTOS.FeedbackResponse> getAllFeedbacks() {
        return feedbackRepository.findAll().stream()
                .map(this::convertToFeedbackResponse)
                .collect(Collectors.toList());
    }

    public List<FeedbackDTOS.FeedbackResponse> getActiveFeedbacks() {
        return feedbackRepository.findByDeleteStatusFalse().stream()
                .map(this::convertToFeedbackResponse)
                .collect(Collectors.toList());
    }

    public List<FeedbackDTOS.FeedbackResponse> getFeedbacksByUserId(Long userId) {
        return feedbackRepository.findByUserId(userId).stream()
                .map(this::convertToFeedbackResponse)
                .collect(Collectors.toList());
    }

    public List<FeedbackDTOS.FeedbackResponse> getActiveFeedbacksByUserId(Long userId) {
        return feedbackRepository.findByUserIdAndDeleteStatusFalse(userId).stream()
                .map(this::convertToFeedbackResponse)
                .collect(Collectors.toList());
    }

    public List<FeedbackDTOS.FeedbackResponse> getFeedbacksByStars(Integer numOfStars) {
        return feedbackRepository.findByNumOfStarsAndDeleteStatusFalse(numOfStars).stream()
                .map(this::convertToFeedbackResponse)
                .collect(Collectors.toList());
    }

    public List<FeedbackDTOS.FeedbackResponse> getFeedbacksByMinStars(Integer minStars) {
        return feedbackRepository.findByMinStarsAndNotDeleted(minStars).stream()
                .map(this::convertToFeedbackResponse)
                .collect(Collectors.toList());
    }

    public List<FeedbackDTOS.FeedbackResponse> getRecentFeedbacks() {
        return feedbackRepository.findActiveOrderByCreatedAtDesc().stream()
                .map(this::convertToFeedbackResponse)
                .collect(Collectors.toList());
    }

    public Optional<FeedbackDTOS.FeedbackResponse> updateFeedback(Long id, FeedbackDTOS.UpdateFeedbackRequest request) {
        return feedbackRepository.findById(id).map(feedback -> {
            UserModel user = userRepository.findById(request.getUserId()).orElseThrow();

            feedback.setTitle(request.getTitle());
            feedback.setSubTitle(request.getSubTitle());
            feedback.setDeleteStatus(request.getDeleteStatus());
            feedback.setNumOfStars(request.getNumOfStars());
            feedback.setUser(user);

            FeedbackModel updatedFeedback = feedbackRepository.save(feedback);
            return convertToFeedbackResponse(updatedFeedback);
        });
    }

    public boolean deleteFeedback(Long id) {
        if (feedbackRepository.existsById(id)) {
            feedbackRepository.deleteById(id);
            return true;
        }
        return false;
    }

    private FeedbackDTOS.FeedbackResponse convertToFeedbackResponse(FeedbackModel feedback) {
        return new FeedbackDTOS.FeedbackResponse(
                feedback.getId(),
                feedback.getTitle(),
                feedback.getSubTitle(),
                feedback.getDeleteStatus(),
                feedback.getCreatedAt(),
                feedback.getNumOfStars(),
                feedback.getUser().getId(),
                feedback.getUser().getFirstName() + " " + feedback.getUser().getLastName(),
                feedback.getUser().getEmail()
        );
    }
}