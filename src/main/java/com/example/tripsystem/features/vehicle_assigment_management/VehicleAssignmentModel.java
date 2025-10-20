package com.example.tripsystem.features.vehicle_assigment_management;

import com.example.tripsystem.features.booking_management.BookingModel;
import com.example.tripsystem.features.vehicle_management.VehicleModel;
import jakarta.persistence.*;

@Entity
@Table(name = "vehicle_assignments")
public class VehicleAssignmentModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "booking_id", nullable = false, unique = true)
    private BookingModel booking;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "vehicle_id", nullable = false)
    private VehicleModel vehicle;

    public VehicleAssignmentModel() {}

    public VehicleAssignmentModel(BookingModel booking, VehicleModel vehicle) {
        this.booking = booking;
        this.vehicle = vehicle;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public BookingModel getBooking() {
        return booking;
    }

    public void setBooking(BookingModel booking) {
        this.booking = booking;
    }

    public VehicleModel getVehicle() {
        return vehicle;
    }

    public void setVehicle(VehicleModel vehicle) {
        this.vehicle = vehicle;
    }
}