package com.example.tripsystem.features.vehicle_management;

import jakarta.persistence.*;

@Entity
@Table(name = "vehicles")
public class VehicleModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "vehicle_number", nullable = false, unique = true)
    private String vehicleNumber;

    @Column(name = "type", nullable = false)
    private String type;

    @Column(name = "num_of_seats", nullable = false)
    private Integer numOfSeats;

    @Column(name = "have_ac", nullable = false)
    private Boolean haveAc;

    @Column(name = "availability", nullable = false)
    private Boolean availability;

    @Column(name = "delete_status", nullable = false)
    private Boolean deleteStatus;

    public VehicleModel() {}

    public VehicleModel(String vehicleNumber, String type, Integer numOfSeats, Boolean haveAc, Boolean availability, Boolean deleteStatus) {
        this.vehicleNumber = vehicleNumber;
        this.type = type;
        this.numOfSeats = numOfSeats;
        this.haveAc = haveAc;
        this.availability = availability;
        this.deleteStatus = deleteStatus;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getVehicleNumber() {
        return vehicleNumber;
    }

    public void setVehicleNumber(String vehicleNumber) {
        this.vehicleNumber = vehicleNumber;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Integer getNumOfSeats() {
        return numOfSeats;
    }

    public void setNumOfSeats(Integer numOfSeats) {
        this.numOfSeats = numOfSeats;
    }

    public Boolean getHaveAc() {
        return haveAc;
    }

    public void setHaveAc(Boolean haveAc) {
        this.haveAc = haveAc;
    }

    public Boolean getAvailability() {
        return availability;
    }

    public void setAvailability(Boolean availability) {
        this.availability = availability;
    }

    public Boolean getDeleteStatus() {
        return deleteStatus;
    }

    public void setDeleteStatus(Boolean deleteStatus) {
        this.deleteStatus = deleteStatus;
    }
}