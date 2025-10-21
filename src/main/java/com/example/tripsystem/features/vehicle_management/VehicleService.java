package com.example.tripsystem.features.vehicle_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class VehicleService {

    @Autowired
    private VehicleRepository vehicleRepository;

    public VehicleDTOS.VehicleResponse createVehicle(VehicleDTOS.CreateVehicleRequest request) {
        VehicleModel vehicle = new VehicleModel(
                request.getVehicleNumber(),
                request.getType(),
                request.getNumOfSeats(),
                request.getHaveAc(),
                request.getAvailability(),
                request.getDeleteStatus()
        );
        VehicleModel savedVehicle = vehicleRepository.save(vehicle);
        return convertToVehicleResponse(savedVehicle);
    }

    public Optional<VehicleDTOS.VehicleResponse> getVehicleById(Long id) {
        return vehicleRepository.findById(id).map(this::convertToVehicleResponse);
    }

    public List<VehicleDTOS.VehicleResponse> getAllVehicles() {
        return vehicleRepository.findAll().stream()
                .map(this::convertToVehicleResponse)
                .collect(Collectors.toList());
    }

    public List<VehicleDTOS.VehicleResponse> getActiveVehicles() {
        return vehicleRepository.findByDeleteStatusFalse().stream()
                .map(this::convertToVehicleResponse)
                .collect(Collectors.toList());
    }

    public List<VehicleDTOS.VehicleResponse> getAvailableVehicles() {
        return vehicleRepository.findByAvailabilityTrueAndDeleteStatusFalse().stream()
                .map(this::convertToVehicleResponse)
                .collect(Collectors.toList());
    }

    public Optional<VehicleDTOS.VehicleResponse> updateVehicle(Long id, VehicleDTOS.UpdateVehicleRequest request) {
        return vehicleRepository.findById(id).map(vehicle -> {
            vehicle.setVehicleNumber(request.getVehicleNumber());
            vehicle.setType(request.getType());
            vehicle.setNumOfSeats(request.getNumOfSeats());
            vehicle.setHaveAc(request.getHaveAc());
            vehicle.setAvailability(request.getAvailability());
            vehicle.setDeleteStatus(request.getDeleteStatus());
            VehicleModel updatedVehicle = vehicleRepository.save(vehicle);
            return convertToVehicleResponse(updatedVehicle);
        });
    }

    public boolean deleteVehicle(Long id) {
        if (vehicleRepository.existsById(id)) {
            vehicleRepository.deleteById(id);
            return true;
        }
        return false;
    }

    private VehicleDTOS.VehicleResponse convertToVehicleResponse(VehicleModel vehicle) {
        return new VehicleDTOS.VehicleResponse(
                vehicle.getId(),
                vehicle.getVehicleNumber(),
                vehicle.getType(),
                vehicle.getNumOfSeats(),
                vehicle.getHaveAc(),
                vehicle.getAvailability(),
                vehicle.getDeleteStatus()
        );
    }
}