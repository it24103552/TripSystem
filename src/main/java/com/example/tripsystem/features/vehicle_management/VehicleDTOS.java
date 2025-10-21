package com.example.tripsystem.features.vehicle_management;

public class VehicleDTOS {

    public static class CreateVehicleRequest {
        private String vehicleNumber;
        private String type;
        private Integer numOfSeats;
        private Boolean haveAc;
        private Boolean availability;
        private Boolean deleteStatus;

        public CreateVehicleRequest() {}

        public CreateVehicleRequest(String vehicleNumber, String type, Integer numOfSeats, Boolean haveAc, Boolean availability, Boolean deleteStatus) {
            this.vehicleNumber = vehicleNumber;
            this.type = type;
            this.numOfSeats = numOfSeats;
            this.haveAc = haveAc;
            this.availability = availability;
            this.deleteStatus = deleteStatus;
        }

        public String getVehicleNumber() { return vehicleNumber; }
        public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }
        public String getType() { return type; }
        public void setType(String type) { this.type = type; }
        public Integer getNumOfSeats() { return numOfSeats; }
        public void setNumOfSeats(Integer numOfSeats) { this.numOfSeats = numOfSeats; }
        public Boolean getHaveAc() { return haveAc; }
        public void setHaveAc(Boolean haveAc) { this.haveAc = haveAc; }
        public Boolean getAvailability() { return availability; }
        public void setAvailability(Boolean availability) { this.availability = availability; }
        public Boolean getDeleteStatus() { return deleteStatus; }
        public void setDeleteStatus(Boolean deleteStatus) { this.deleteStatus = deleteStatus; }
    }

    public static class UpdateVehicleRequest {
        private String vehicleNumber;
        private String type;
        private Integer numOfSeats;
        private Boolean haveAc;
        private Boolean availability;
        private Boolean deleteStatus;

        public UpdateVehicleRequest() {}

        public UpdateVehicleRequest(String vehicleNumber, String type, Integer numOfSeats, Boolean haveAc, Boolean availability, Boolean deleteStatus) {
            this.vehicleNumber = vehicleNumber;
            this.type = type;
            this.numOfSeats = numOfSeats;
            this.haveAc = haveAc;
            this.availability = availability;
            this.deleteStatus = deleteStatus;
        }

        public String getVehicleNumber() { return vehicleNumber; }
        public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }
        public String getType() { return type; }
        public void setType(String type) { this.type = type; }
        public Integer getNumOfSeats() { return numOfSeats; }
        public void setNumOfSeats(Integer numOfSeats) { this.numOfSeats = numOfSeats; }
        public Boolean getHaveAc() { return haveAc; }
        public void setHaveAc(Boolean haveAc) { this.haveAc = haveAc; }
        public Boolean getAvailability() { return availability; }
        public void setAvailability(Boolean availability) { this.availability = availability; }
        public Boolean getDeleteStatus() { return deleteStatus; }
        public void setDeleteStatus(Boolean deleteStatus) { this.deleteStatus = deleteStatus; }
    }

    public static class VehicleResponse {
        private Long id;
        private String vehicleNumber;
        private String type;
        private Integer numOfSeats;
        private Boolean haveAc;
        private Boolean availability;
        private Boolean deleteStatus;

        public VehicleResponse() {}

        public VehicleResponse(Long id, String vehicleNumber, String type, Integer numOfSeats, Boolean haveAc, Boolean availability, Boolean deleteStatus) {
            this.id = id;
            this.vehicleNumber = vehicleNumber;
            this.type = type;
            this.numOfSeats = numOfSeats;
            this.haveAc = haveAc;
            this.availability = availability;
            this.deleteStatus = deleteStatus;
        }

        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }
        public String getVehicleNumber() { return vehicleNumber; }
        public void setVehicleNumber(String vehicleNumber) { this.vehicleNumber = vehicleNumber; }
        public String getType() { return type; }
        public void setType(String type) { this.type = type; }
        public Integer getNumOfSeats() { return numOfSeats; }
        public void setNumOfSeats(Integer numOfSeats) { this.numOfSeats = numOfSeats; }
        public Boolean getHaveAc() { return haveAc; }
        public void setHaveAc(Boolean haveAc) { this.haveAc = haveAc; }
        public Boolean getAvailability() { return availability; }
        public void setAvailability(Boolean availability) { this.availability = availability; }
        public Boolean getDeleteStatus() { return deleteStatus; }
        public void setDeleteStatus(Boolean deleteStatus) { this.deleteStatus = deleteStatus; }
    }
}