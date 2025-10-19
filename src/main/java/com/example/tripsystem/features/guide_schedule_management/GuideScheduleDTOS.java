package com.example.tripsystem.features.guide_schedule_management;

import java.time.LocalDate;

public class GuideScheduleDTOS {

    public static class CreateGuideScheduleRequest {
        private Long guideId;
        private Long bookingId;

        public CreateGuideScheduleRequest() {}

        public CreateGuideScheduleRequest(Long guideId, Long bookingId) {
            this.guideId = guideId;
            this.bookingId = bookingId;
        }

        public Long getGuideId() { return guideId; }
        public void setGuideId(Long guideId) { this.guideId = guideId; }
        public Long getBookingId() { return bookingId; }
        public void setBookingId(Long bookingId) { this.bookingId = bookingId; }
    }

    public static class UpdateGuideScheduleRequest {
        private Long guideId;
        private Long bookingId;

        public UpdateGuideScheduleRequest() {}

        public UpdateGuideScheduleRequest(Long guideId, Long bookingId) {
            this.guideId = guideId;
            this.bookingId = bookingId;
        }

        public Long getGuideId() { return guideId; }
        public void setGuideId(Long guideId) { this.guideId = guideId; }
        public Long getBookingId() { return bookingId; }
        public void setBookingId(Long bookingId) { this.bookingId = bookingId; }
    }

    public static class GuideScheduleResponse {
        private Long id;
        private Long guideId;
        private String guideName;
        private String guideEmail;
        private Long bookingId;
        private LocalDate bookingDate;

        public GuideScheduleResponse() {}

        public GuideScheduleResponse(Long id, Long guideId, String guideName, String guideEmail, Long bookingId, LocalDate bookingDate) {
            this.id = id;
            this.guideId = guideId;
            this.guideName = guideName;
            this.guideEmail = guideEmail;
            this.bookingId = bookingId;
            this.bookingDate = bookingDate;
        }

        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }
        public Long getGuideId() { return guideId; }
        public void setGuideId(Long guideId) { this.guideId = guideId; }
        public String getGuideName() { return guideName; }
        public void setGuideName(String guideName) { this.guideName = guideName; }
        public String getGuideEmail() { return guideEmail; }
        public void setGuideEmail(String guideEmail) { this.guideEmail = guideEmail; }
        public Long getBookingId() { return bookingId; }
        public void setBookingId(Long bookingId) { this.bookingId = bookingId; }
        public LocalDate getBookingDate() { return bookingDate; }
        public void setBookingDate(LocalDate bookingDate) { this.bookingDate = bookingDate; }
    }
}