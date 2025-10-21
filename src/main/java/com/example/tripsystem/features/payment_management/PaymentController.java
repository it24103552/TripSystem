package com.example.tripsystem.features.payment_management;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api/payments")
public class PaymentController {

    @Autowired
    private PaymentService paymentService;

    @PostMapping
    public ResponseEntity<?> createPayment(@RequestBody PaymentDTOS.CreatePaymentRequest request) {
        try {
            PaymentDTOS.PaymentResponse response = paymentService.createPayment(request);
            return ResponseEntity.status(HttpStatus.CREATED).body(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error creating payment: " + e.getMessage());
        }
    }

    @GetMapping("/{id}")
    public ResponseEntity<?> getPaymentById(@PathVariable Long id) {
        try {
            Optional<PaymentDTOS.PaymentResponse> payment = paymentService.getPaymentById(id);
            if (payment.isPresent()) {
                return ResponseEntity.ok(payment.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Payment not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving payment: " + e.getMessage());
        }
    }

    @GetMapping
    public ResponseEntity<?> getAllPayments() {
        try {
            List<PaymentDTOS.PaymentResponse> payments = paymentService.getAllPayments();
            return ResponseEntity.ok(payments);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving payments: " + e.getMessage());
        }
    }

    @GetMapping("/active")
    public ResponseEntity<?> getActivePayments() {
        try {
            List<PaymentDTOS.PaymentResponse> payments = paymentService.getActivePayments();
            return ResponseEntity.ok(payments);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving active payments: " + e.getMessage());
        }
    }

    @GetMapping("/user/{userId}")
    public ResponseEntity<?> getPaymentsByUserId(@PathVariable Long userId) {
        try {
            List<PaymentDTOS.PaymentResponse> payments = paymentService.getPaymentsByUserId(userId);
            return ResponseEntity.ok(payments);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving user payments: " + e.getMessage());
        }
    }

    @GetMapping("/user/{userId}/active")
    public ResponseEntity<?> getActivePaymentsByUserId(@PathVariable Long userId) {
        try {
            List<PaymentDTOS.PaymentResponse> payments = paymentService.getActivePaymentsByUserId(userId);
            return ResponseEntity.ok(payments);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving active user payments: " + e.getMessage());
        }
    }

    @GetMapping("/booking/{bookingId}")
    public ResponseEntity<?> getPaymentByBookingId(@PathVariable Long bookingId) {
        try {
            Optional<PaymentDTOS.PaymentResponse> payment = paymentService.getPaymentByBookingId(bookingId);
            if (payment.isPresent()) {
                return ResponseEntity.ok(payment.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Payment not found for booking");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving payment by booking: " + e.getMessage());
        }
    }

    @GetMapping("/status/{status}")
    public ResponseEntity<?> getPaymentsByStatus(@PathVariable String status) {
        try {
            List<PaymentDTOS.PaymentResponse> payments = paymentService.getPaymentsByStatus(status);
            return ResponseEntity.ok(payments);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving payments by status: " + e.getMessage());
        }
    }

    @GetMapping("/method/{method}")
    public ResponseEntity<?> getPaymentsByMethod(@PathVariable String method) {
        try {
            List<PaymentDTOS.PaymentResponse> payments = paymentService.getPaymentsByMethod(method);
            return ResponseEntity.ok(payments);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving payments by method: " + e.getMessage());
        }
    }

    @GetMapping("/amount-range")
    public ResponseEntity<?> getPaymentsByAmountRange(@RequestParam BigDecimal minAmount, @RequestParam BigDecimal maxAmount) {
        try {
            List<PaymentDTOS.PaymentResponse> payments = paymentService.getPaymentsByAmountRange(minAmount, maxAmount);
            return ResponseEntity.ok(payments);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error retrieving payments by amount range: " + e.getMessage());
        }
    }

    @PutMapping("/{id}")
    public ResponseEntity<?> updatePayment(@PathVariable Long id, @RequestBody PaymentDTOS.UpdatePaymentRequest request) {
        try {
            Optional<PaymentDTOS.PaymentResponse> updatedPayment = paymentService.updatePayment(id, request);
            if (updatedPayment.isPresent()) {
                return ResponseEntity.ok(updatedPayment.get());
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Payment not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error updating payment: " + e.getMessage());
        }
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<?> deletePayment(@PathVariable Long id) {
        try {
            boolean deleted = paymentService.deletePayment(id);
            if (deleted) {
                return ResponseEntity.ok("Payment deleted successfully");
            } else {
                return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Payment not found");
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error deleting payment: " + e.getMessage());
        }
    }
}