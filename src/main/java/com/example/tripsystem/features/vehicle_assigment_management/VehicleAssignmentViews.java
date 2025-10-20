package com.example.tripsystem.features.vehicle_assigment_management;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class VehicleAssignmentViews {
    @GetMapping("/vehicle-assignments")
    public  String vehicleAssignments(){
        return "vehicle-assignments/vehicle-assignments";
    }
}
