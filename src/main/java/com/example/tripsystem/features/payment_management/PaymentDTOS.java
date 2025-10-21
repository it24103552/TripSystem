package com.example.tripsystem.features.payment_management;

import java.math.BigDecimal;

public class PaymentDTOS {

    public static class CreatePaymentRequest {
        private Boolean deleteStatus;
        private String status;
        private BigDecimal amount;
        private String method;
        private Long paidBy;
        private Long paidTo;

        public CreatePaymentRequest() {}

        public CreatePaymentRequest(Boolean deleteStatus, String status, BigDecimal amount, String method, Long paidBy, Long paidTo) {
            this.deleteStatus = deleteStatus;
            this.status = status;
            this.amount = amount;
            this.method = method;
            this.paidBy = paidBy;
            this.paidTo = paidTo;
        }

        public Boolean getDeleteStatus() { return deleteStatus; }
        public void setDeleteStatus(Boolean deleteStatus) { this.deleteStatus = deleteStatus; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public BigDecimal getAmount() { return amount; }
        public void setAmount(BigDecimal amount) { this.amount = amount; }
        public String getMethod() { return method; }
        public void setMethod(String method) { this.method = method; }
        public Long getPaidBy() { return paidBy; }
        public void setPaidBy(Long paidBy) { this.paidBy = paidBy; }
        public Long getPaidTo() { return paidTo; }
        public void setPaidTo(Long paidTo) { this.paidTo = paidTo; }
    }

    public static class UpdatePaymentRequest {
        private Boolean deleteStatus;
        private String status;
        private BigDecimal amount;
        private String method;
        private Long paidBy;
        private Long paidTo;

        public UpdatePaymentRequest() {}

        public UpdatePaymentRequest(Boolean deleteStatus, String status, BigDecimal amount, String method, Long paidBy, Long paidTo) {
            this.deleteStatus = deleteStatus;
            this.status = status;
            this.amount = amount;
            this.method = method;
            this.paidBy = paidBy;
            this.paidTo = paidTo;
        }

        public Boolean getDeleteStatus() { return deleteStatus; }
        public void setDeleteStatus(Boolean deleteStatus) { this.deleteStatus = deleteStatus; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public BigDecimal getAmount() { return amount; }
        public void setAmount(BigDecimal amount) { this.amount = amount; }
        public String getMethod() { return method; }
        public void setMethod(String method) { this.method = method; }
        public Long getPaidBy() { return paidBy; }
        public void setPaidBy(Long paidBy) { this.paidBy = paidBy; }
        public Long getPaidTo() { return paidTo; }
        public void setPaidTo(Long paidTo) { this.paidTo = paidTo; }
    }

    public static class PaymentResponse {
        private Long id;
        private Boolean deleteStatus;
        private String status;
        private BigDecimal amount;
        private String method;
        private Long paidById;
        private String paidByName;
        private String paidByEmail;
        private Long paidToBookingId;
        private String bookingDate;


        public PaymentResponse() {}

        public PaymentResponse(Long id, Boolean deleteStatus, String status, BigDecimal amount, String method,
                               Long paidById, String paidByName, String paidByEmail, Long paidToBookingId,
                               String bookingDate) {
            this.id = id;
            this.deleteStatus = deleteStatus;
            this.status = status;
            this.amount = amount;
            this.method = method;
            this.paidById = paidById;
            this.paidByName = paidByName;
            this.paidByEmail = paidByEmail;
            this.paidToBookingId = paidToBookingId;
            this.bookingDate = bookingDate;

        }

        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }
        public Boolean getDeleteStatus() { return deleteStatus; }
        public void setDeleteStatus(Boolean deleteStatus) { this.deleteStatus = deleteStatus; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
        public BigDecimal getAmount() { return amount; }
        public void setAmount(BigDecimal amount) { this.amount = amount; }
        public String getMethod() { return method; }
        public void setMethod(String method) { this.method = method; }
        public Long getPaidById() { return paidById; }
        public void setPaidById(Long paidById) { this.paidById = paidById; }
        public String getPaidByName() { return paidByName; }
        public void setPaidByName(String paidByName) { this.paidByName = paidByName; }
        public String getPaidByEmail() { return paidByEmail; }
        public void setPaidByEmail(String paidByEmail) { this.paidByEmail = paidByEmail; }
        public Long getPaidToBookingId() { return paidToBookingId; }
        public void setPaidToBookingId(Long paidToBookingId) { this.paidToBookingId = paidToBookingId; }
        public String getBookingDate() { return bookingDate; }
        public void setBookingDate(String bookingDate) { this.bookingDate = bookingDate; }

    }
}