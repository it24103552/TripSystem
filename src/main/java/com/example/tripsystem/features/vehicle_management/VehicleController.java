package com.example.tripsystem.features.vehicle_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/vehicles")
public class VehicleController {

    @Autowired
    private VehicleService vehicleService;

    @PostMapping
    public ResponseEntity<?> createVehicle(@RequestBody VehicleDTOS.CreateVehicleRequest request) {
        try {
            VehicleDTOS.VehicleResponse response = vehicleService.createVehicle(request);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error creating vehicle: " + e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getVehicleById(@PathVariable Long id) {
        try {
            Optional<VehicleDTOS.VehicleResponse> vehicle = vehicleService.getVehicleById(id);
            if (vehicle.isPresent()) {
                return ResponseEntity.ok(vehicle.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Vehicle not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving vehicle: " + e.getMessage());
        }
    }

    @GetMapping
    public ResponseEntity<?> getAllVehicles() {
        try {
            List<VehicleDTOS.VehicleResponse> vehicles = vehicleService.getAllVehicles();
            return ResponseEntity.ok(vehicles);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving vehicles: " + e.getMessage());
        }
    }

    @GetMapping("/active")
    public ResponseEntity<?> getActiveVehicles() {
        try {
            List<VehicleDTOS.VehicleResponse> vehicles = vehicleService.getActiveVehicles();
            return ResponseEntity.ok(vehicles);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving active vehicles: " + e.getMessage());
        }
    }

    @GetMapping("/available")
    public ResponseEntity<?> getAvailableVehicles() {
        try {
            List<VehicleDTOS.VehicleResponse> vehicles = vehicleService.getAvailableVehicles();
            return ResponseEntity.ok(vehicles);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving available vehicles: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateVehicle(@PathVariable Long id, @RequestBody VehicleDTOS.UpdateVehicleRequest request) {
        try {
            Optional<VehicleDTOS.VehicleResponse> updatedVehicle = vehicleService.updateVehicle(id, request);
            if (updatedVehicle.isPresent()) {
                return ResponseEntity.ok(updatedVehicle.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Vehicle not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating vehicle: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteVehicle(@PathVariable Long id) {
        try {
            boolean deleted = vehicleService.deleteVehicle(id);
            if (deleted) {
                return ResponseEntity.ok("Vehicle deleted successfully");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Vehicle not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error deleting vehicle: " + e.getMessage());
        }
    }
}