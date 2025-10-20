package com.example.tripsystem.features.vehicle_assigment_management;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VehicleAssignmentRepository extends JpaRepository<VehicleAssignmentModel, Long> {
    Optional<VehicleAssignmentModel> findByBookingId(Long bookingId);
    List<VehicleAssignmentModel> findAll();
    boolean existsById(Long id);
}