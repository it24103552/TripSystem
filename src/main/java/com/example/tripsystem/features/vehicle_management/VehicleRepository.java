package com.example.tripsystem.features.vehicle_management;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VehicleRepository extends JpaRepository<VehicleModel, Long> {
    Optional<VehicleModel> findByVehicleNumber(String vehicleNumber);
    List<VehicleModel> findByDeleteStatusFalse();
    List<VehicleModel> findByAvailabilityTrueAndDeleteStatusFalse();
    List<VehicleModel> findByTypeAndDeleteStatusFalse(String type);
}