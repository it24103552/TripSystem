package com.example.tripsystem.features.feedback_management;

import java.time.LocalDateTime;

public class FeedbackDTOS {

    public static class CreateFeedbackRequest {
        private String title;
        private String subTitle;
        private Boolean deleteStatus;
        private Integer numOfStars;
        private Long userId;

        public CreateFeedbackRequest() {}

        public CreateFeedbackRequest(String title, String subTitle, Boolean deleteStatus, Integer numOfStars, Long userId) {
            this.title = title;
            this.subTitle = subTitle;
            this.deleteStatus = deleteStatus;
            this.numOfStars = numOfStars;
            this.userId = userId;
        }

        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        public String getSubTitle() { return subTitle; }
        public void setSubTitle(String subTitle) { this.subTitle = subTitle; }
        public Boolean getDeleteStatus() { return deleteStatus; }
        public void setDeleteStatus(Boolean deleteStatus) { this.deleteStatus = deleteStatus; }
        public Integer getNumOfStars() { return numOfStars; }
        public void setNumOfStars(Integer numOfStars) { this.numOfStars = numOfStars; }
        public Long getUserId() { return userId; }
        public void setUserId(Long userId) { this.userId = userId; }
    }

    public static class UpdateFeedbackRequest {
        private String title;
        private String subTitle;
        private Boolean deleteStatus;
        private Integer numOfStars;
        private Long userId;

        public UpdateFeedbackRequest() {}

        public UpdateFeedbackRequest(String title, String subTitle, Boolean deleteStatus, Integer numOfStars, Long userId) {
            this.title = title;
            this.subTitle = subTitle;
            this.deleteStatus = deleteStatus;
            this.numOfStars = numOfStars;
            this.userId = userId;
        }

        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        public String getSubTitle() { return subTitle; }
        public void setSubTitle(String subTitle) { this.subTitle = subTitle; }
        public Boolean getDeleteStatus() { return deleteStatus; }
        public void setDeleteStatus(Boolean deleteStatus) { this.deleteStatus = deleteStatus; }
        public Integer getNumOfStars() { return numOfStars; }
        public void setNumOfStars(Integer numOfStars) { this.numOfStars = numOfStars; }
        public Long getUserId() { return userId; }
        public void setUserId(Long userId) { this.userId = userId; }
    }

    public static class FeedbackResponse {
        private Long id;
        private String title;
        private String subTitle;
        private Boolean deleteStatus;
        private LocalDateTime createdAt;
        private Integer numOfStars;
        private Long userId;
        private String userName;
        private String userEmail;

        public FeedbackResponse() {}

        public FeedbackResponse(Long id, String title, String subTitle, Boolean deleteStatus, LocalDateTime createdAt,
                                Integer numOfStars, Long userId, String userName, String userEmail) {
            this.id = id;
            this.title = title;
            this.subTitle = subTitle;
            this.deleteStatus = deleteStatus;
            this.createdAt = createdAt;
            this.numOfStars = numOfStars;
            this.userId = userId;
            this.userName = userName;
            this.userEmail = userEmail;
        }

        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }
        public String getTitle() { return title; }
        public void setTitle(String title) { this.title = title; }
        public String getSubTitle() { return subTitle; }
        public void setSubTitle(String subTitle) { this.subTitle = subTitle; }
        public Boolean getDeleteStatus() { return deleteStatus; }
        public void setDeleteStatus(Boolean deleteStatus) { this.deleteStatus = deleteStatus; }
        public LocalDateTime getCreatedAt() { return createdAt; }
        public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
        public Integer getNumOfStars() { return numOfStars; }
        public void setNumOfStars(Integer numOfStars) { this.numOfStars = numOfStars; }
        public Long getUserId() { return userId; }
        public void setUserId(Long userId) { this.userId = userId; }
        public String getUserName() { return userName; }
        public void setUserName(String userName) { this.userName = userName; }
        public String getUserEmail() { return userEmail; }
        public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
    }
}