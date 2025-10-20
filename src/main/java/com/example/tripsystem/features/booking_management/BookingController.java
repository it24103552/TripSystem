package com.example.tripsystem.features.booking_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/bookings")
public class BookingController {

    @Autowired
    private BookingService bookingService;

    @PostMapping
    public ResponseEntity<?> createBooking(@RequestBody BookingDTOS.CreateBookingRequest request) {
        try {
            BookingDTOS.BookingResponse response = bookingService.createBooking(request);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error creating booking: " + e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getBookingById(@PathVariable Long id) {
        try {
            Optional<BookingDTOS.BookingResponse> booking = bookingService.getBookingById(id);
            if (booking.isPresent()) {
                return ResponseEntity.ok(booking.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Booking not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving booking: " + e.getMessage());
        }
    }

    @GetMapping
    public ResponseEntity<?> getAllBookings() {
        try {
            List<BookingDTOS.BookingResponse> bookings = bookingService.getAllBookings();
            return ResponseEntity.ok(bookings);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving bookings: " + e.getMessage());
        }
    }

    @GetMapping("/customer/{customerId}")
    public ResponseEntity<?> getBookingsByCustomerId(@PathVariable Long customerId) {
        try {
            List<BookingDTOS.BookingResponse> bookings = bookingService.getBookingsByCustomerId(customerId);
            return ResponseEntity.ok(bookings);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving customer bookings: " + e.getMessage());
        }
    }

    @GetMapping("/date/{date}")
    public ResponseEntity<?> getBookingsByDate(@PathVariable @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date) {
        try {
            List<BookingDTOS.BookingResponse> bookings = bookingService.getBookingsByDate(date);
            return ResponseEntity.ok(bookings);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving bookings by date: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updateBooking(@PathVariable Long id, @RequestBody BookingDTOS.UpdateBookingRequest request) {
        try {
            Optional<BookingDTOS.BookingResponse> updatedBooking = bookingService.updateBooking(id, request);
            if (updatedBooking.isPresent()) {
                return ResponseEntity.ok(updatedBooking.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Booking not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating booking: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteBooking(@PathVariable Long id) {
        try {
            boolean deleted = bookingService.deleteBooking(id);
            if (deleted) {
                return ResponseEntity.ok("Booking deleted successfully");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Booking not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error deleting booking: " + e.getMessage());
        }
    }
}