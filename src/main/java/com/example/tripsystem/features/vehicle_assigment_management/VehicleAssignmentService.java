package com.example.tripsystem.features.vehicle_assigment_management;

import com.example.tripsystem.features.booking_management.BookingModel;
import com.example.tripsystem.features.booking_management.BookingRepository;
import com.example.tripsystem.features.user_management.UserModel;
import com.example.tripsystem.features.vehicle_management.VehicleModel;
import com.example.tripsystem.features.vehicle_management.VehicleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class VehicleAssignmentService {

    @Autowired
    private VehicleAssignmentRepository vehicleAssignmentRepository;

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private VehicleRepository vehicleRepository;

    public VehicleAssignmentDTOS.VehicleAssignmentResponse createVehicleAssignment(VehicleAssignmentDTOS.CreateVehicleAssignmentRequest request) {
        BookingModel booking = bookingRepository.findById(request.getBookingId()).orElseThrow(() -> new RuntimeException("Booking not found"));
        VehicleModel vehicle = vehicleRepository.findById(request.getVehicleId()).orElseThrow(() -> new RuntimeException("Vehicle not found"));

        VehicleAssignmentModel assignment = new VehicleAssignmentModel(booking, vehicle);
        VehicleAssignmentModel savedAssignment = vehicleAssignmentRepository.save(assignment);
        return convertToResponse(savedAssignment);
    }

    public Optional<VehicleAssignmentDTOS.VehicleAssignmentResponse> getVehicleAssignmentById(Long id) {
        return vehicleAssignmentRepository.findById(id).map(this::convertToResponse);
    }

    public List<VehicleAssignmentDTOS.VehicleAssignmentResponse> getAllVehicleAssignments() {
        return vehicleAssignmentRepository.findAll().stream()
                .map(this::convertToResponse)
                .collect(Collectors.toList());
    }

    public Optional<VehicleAssignmentDTOS.VehicleAssignmentResponse> updateVehicleAssignment(Long id, VehicleAssignmentDTOS.UpdateVehicleAssignmentRequest request) {
        return vehicleAssignmentRepository.findById(id).map(assignment -> {
            BookingModel booking = bookingRepository.findById(request.getBookingId()).orElseThrow(() -> new RuntimeException("Booking not found"));
            VehicleModel vehicle = vehicleRepository.findById(request.getVehicleId()).orElseThrow(() -> new RuntimeException("Vehicle not found"));

            assignment.setBooking(booking);
            assignment.setVehicle(vehicle);
            VehicleAssignmentModel updatedAssignment = vehicleAssignmentRepository.save(assignment);
            return convertToResponse(updatedAssignment);
        });
    }

    public boolean deleteVehicleAssignment(Long id) {
        if (vehicleAssignmentRepository.existsById(id)) {
            vehicleAssignmentRepository.deleteById(id);
            return true;
        }
        return false;
    }

    private VehicleAssignmentDTOS.VehicleAssignmentResponse convertToResponse(VehicleAssignmentModel assignment) {
        BookingModel booking = assignment.getBooking();
        UserModel customer = booking.getCustomer();
        VehicleModel vehicle = assignment.getVehicle();
        return new VehicleAssignmentDTOS.VehicleAssignmentResponse(
                assignment.getId(),
                booking.getId(),
                customer.getFirstName() + " " + customer.getLastName(),
                customer.getEmail(),
                vehicle.getId(),
                vehicle.getVehicleNumber(),
                vehicle.getType()
        );
    }
}