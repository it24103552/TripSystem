package com.example.tripsystem.features.vehicle_management;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class VehicleViews {
    @GetMapping("/vehicle-management")
    public  String vehicleManagement(){
        return "vehicle-management/vehicle-management";
    }
}
