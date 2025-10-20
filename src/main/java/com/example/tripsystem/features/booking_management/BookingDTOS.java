package com.example.tripsystem.features.booking_management;

import java.time.LocalDate;

public class BookingDTOS {

    public static class CreateBookingRequest {
        private LocalDate bookingDate;
        private Long customerId;
        private String additionalNotes;
        private String status;

        public CreateBookingRequest() {}

        public CreateBookingRequest(LocalDate bookingDate, Long customerId, String additionalNotes, String status) {
            this.bookingDate = bookingDate;
            this.customerId = customerId;
            this.additionalNotes = additionalNotes;
            this.status = status;
        }

        public LocalDate getBookingDate() { return bookingDate; }
        public void setBookingDate(LocalDate bookingDate) { this.bookingDate = bookingDate; }
        public Long getCustomerId() { return customerId; }
        public void setCustomerId(Long customerId) { this.customerId = customerId; }
        public String getAdditionalNotes() { return additionalNotes; }
        public void setAdditionalNotes(String additionalNotes) { this.additionalNotes = additionalNotes; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
    }

    public static class UpdateBookingRequest {
        private LocalDate bookingDate;
        private Long customerId;
        private String additionalNotes;
        private String status;

        public UpdateBookingRequest() {}

        public UpdateBookingRequest(LocalDate bookingDate, Long customerId, String additionalNotes, String status) {
            this.bookingDate = bookingDate;
            this.customerId = customerId;
            this.additionalNotes = additionalNotes;
            this.status = status;
        }

        public LocalDate getBookingDate() { return bookingDate; }
        public void setBookingDate(LocalDate bookingDate) { this.bookingDate = bookingDate; }
        public Long getCustomerId() { return customerId; }
        public void setCustomerId(Long customerId) { this.customerId = customerId; }
        public String getAdditionalNotes() { return additionalNotes; }
        public void setAdditionalNotes(String additionalNotes) { this.additionalNotes = additionalNotes; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
    }

    public static class BookingResponse {
        private Long id;
        private LocalDate bookingDate;
        private Long customerId;
        private String customerName;
        private String customerEmail;
        private String additionalNotes;
        private String status;

        public BookingResponse() {}

        public BookingResponse(Long id, LocalDate bookingDate, Long customerId, String customerName, String customerEmail, String additionalNotes, String status) {
            this.id = id;
            this.bookingDate = bookingDate;
            this.customerId = customerId;
            this.customerName = customerName;
            this.customerEmail = customerEmail;
            this.additionalNotes = additionalNotes;
            this.status = status;
        }

        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }
        public LocalDate getBookingDate() { return bookingDate; }
        public void setBookingDate(LocalDate bookingDate) { this.bookingDate = bookingDate; }
        public Long getCustomerId() { return customerId; }
        public void setCustomerId(Long customerId) { this.customerId = customerId; }
        public String getCustomerName() { return customerName; }
        public void setCustomerName(String customerName) { this.customerName = customerName; }
        public String getCustomerEmail() { return customerEmail; }
        public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
        public String getAdditionalNotes() { return additionalNotes; }
        public void setAdditionalNotes(String additionalNotes) { this.additionalNotes = additionalNotes; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
    }
}