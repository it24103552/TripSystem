package com.example.tripsystem.features.vehicle_assigment_management;

public class VehicleAssignmentDTOS {

    public static class CreateVehicleAssignmentRequest {
        private Long bookingId;
        private Long vehicleId;

        public CreateVehicleAssignmentRequest() {}

        public CreateVehicleAssignmentRequest(Long bookingId, Long vehicleId) {
            this.bookingId = bookingId;
            this.vehicleId = vehicleId;
        }

        public Long getBookingId() { return bookingId; }
        public void setBookingId(Long bookingId) { this.bookingId = bookingId; }
        public Long getVehicleId() { return vehicleId; }
        public void setVehicleId(Long vehicleId) { this.vehicleId = vehicleId; }
    }

    public static class UpdateVehicleAssignmentRequest {
        private Long bookingId;
        private Long vehicleId;

        public UpdateVehicleAssignmentRequest() {}

        public UpdateVehicleAssignmentRequest(Long bookingId, Long vehicleId) {
            this.bookingId = bookingId;
            this.vehicleId = vehicleId;
        }

        public Long getBookingId() { return bookingId; }
        public void setBookingId(Long bookingId) { this.bookingId = bookingId; }
        public Long getVehicleId() { return vehicleId; }
        public void setVehicleId(Long vehicleId) { this.vehicleId = vehicleId; }
    }

    public static class VehicleAssignmentResponse {
        private Long id;
        private Long bookingId;
        private String customerName;
        private String customerEmail;
        private Long vehicleId;
        private String vehicleNumber;
        private String vehicleType;

        public VehicleAssignmentResponse() {}

        public VehicleAssignmentResponse(Long id, Long bookingId, String customerName, String customerEmail, Long vehicleId, String vehicleNumber, String vehicleType) {
            this.id = id;
            this.bookingId = bookingId;
            this.customerName = customerName;
            this.customerEmail = customerEmail;
            this.vehicleId = vehicleId;
            this.vehicleNumber = vehicleNumber;
            this.vehicleType = vehicleType;
        }

        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }
        public Long getBookingId() { return bookingId; }
        public void setBookingId(Long bookingId) { this.bookingId = bookingId; }
        public String getCustomerName() { return customerName; }
        public void setCustomerName(String customerName) { this.customerName = customerName; }
        public String getCustomerEmail() { return customerEmail; }
        public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
        public Long getVehicleId() { return vehicleId; }
        public void setVehicleId(Long vehicleId) { this.vehicleId = vehicleId; }
        public String getVehicleNumber() { return vehicleNumber; }
        public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }
        public String getVehicleType() { return vehicleType; }
        public void setVehicleType(String vehicleType) { this.vehicleType = vehicleType; }
    }
}