package com.example.tripsystem.features.vehicle_assigment_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/vehicle-assignments")
public class VehicleAssignmentController {

    @Autowired
    private VehicleAssignmentService vehicleAssignmentService;

    @PostMapping
    public ResponseEntity<?> createVehicleAssignment(@RequestBody VehicleAssignmentDTOS.CreateVehicleAssignmentRequest request) {
        try {
            VehicleAssignmentDTOS.VehicleAssignmentResponse response = vehicleAssignmentService.createVehicleAssignment(request);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error creating vehicle assignment: " + e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getVehicleAssignmentById(@PathVariable Long id) {
        try {
            Optional<VehicleAssignmentDTOS.VehicleAssignmentResponse> assignment = vehicleAssignmentService.getVehicleAssignmentById(id);
            if (assignment.isPresent()) {
                return ResponseEntity.ok(assignment.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Vehicle assignment not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving vehicle assignment: " + e.getMessage());
        }
    }

    @GetMapping
    public ResponseEntity<?> getAllVehicleAssignments() {
        try {
            List<VehicleAssignmentDTOS.VehicleAssignmentResponse> assignments = vehicleAssignmentService.getAllVehicleAssignments();
            return ResponseEntity.ok(assignments);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving vehicle assignments: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateVehicleAssignment(@PathVariable Long id, @RequestBody VehicleAssignmentDTOS.UpdateVehicleAssignmentRequest request) {
        try {
            Optional<VehicleAssignmentDTOS.VehicleAssignmentResponse> updatedAssignment = vehicleAssignmentService.updateVehicleAssignment(id, request);
            if (updatedAssignment.isPresent()) {
                return ResponseEntity.ok(updatedAssignment.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Vehicle assignment not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating vehicle assignment: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteVehicleAssignment(@PathVariable Long id) {
        try {
            boolean deleted = vehicleAssignmentService.deleteVehicleAssignment(id);
            if (deleted) {
                return ResponseEntity.ok("Vehicle assignment deleted successfully");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Vehicle assignment not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error deleting vehicle assignment: " + e.getMessage());
        }
    }
}