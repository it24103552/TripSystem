package com.example.tripsystem.features.payment_management;

import com.example.tripsystem.features.user_management.UserModel;
import com.example.tripsystem.features.user_management.UserRepository;
import com.example.tripsystem.features.booking_management.BookingModel;
import com.example.tripsystem.features.booking_management.BookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BookingRepository bookingRepository;

    public PaymentDTOS.PaymentResponse createPayment(PaymentDTOS.CreatePaymentRequest request) {
        UserModel paidBy = userRepository.findById(request.getPaidBy()).orElseThrow();
        BookingModel paidTo = bookingRepository.findById(request.getPaidTo()).orElseThrow();

        PaymentModel payment = new PaymentModel(
                request.getDeleteStatus(),
                request.getStatus(),
                request.getAmount(),
                request.getMethod(),
                paidBy,
                paidTo
        );

        PaymentModel savedPayment = paymentRepository.save(payment);
        return convertToPaymentResponse(savedPayment);
    }

    public Optional<PaymentDTOS.PaymentResponse> getPaymentById(Long id) {
        return paymentRepository.findById(id).map(this::convertToPaymentResponse);
    }

    public List<PaymentDTOS.PaymentResponse> getAllPayments() {
        return paymentRepository.findAll().stream()
                .map(this::convertToPaymentResponse)
                .collect(Collectors.toList());
    }

    public List<PaymentDTOS.PaymentResponse> getActivePayments() {
        return paymentRepository.findByDeleteStatusFalse().stream()
                .map(this::convertToPaymentResponse)
                .collect(Collectors.toList());
    }

    public List<PaymentDTOS.PaymentResponse> getPaymentsByUserId(Long userId) {
        return paymentRepository.findByPaidById(userId).stream()
                .map(this::convertToPaymentResponse)
                .collect(Collectors.toList());
    }

    public List<PaymentDTOS.PaymentResponse> getActivePaymentsByUserId(Long userId) {
        return paymentRepository.findByPaidByIdAndDeleteStatusFalse(userId).stream()
                .map(this::convertToPaymentResponse)
                .collect(Collectors.toList());
    }

    public Optional<PaymentDTOS.PaymentResponse> getPaymentByBookingId(Long bookingId) {
        return paymentRepository.findByPaidToId(bookingId).map(this::convertToPaymentResponse);
    }

    public List<PaymentDTOS.PaymentResponse> getPaymentsByStatus(String status) {
        return paymentRepository.findByStatusAndDeleteStatusFalse(status).stream()
                .map(this::convertToPaymentResponse)
                .collect(Collectors.toList());
    }

    public List<PaymentDTOS.PaymentResponse> getPaymentsByMethod(String method) {
        return paymentRepository.findByMethodAndDeleteStatusFalse(method).stream()
                .map(this::convertToPaymentResponse)
                .collect(Collectors.toList());
    }

    public List<PaymentDTOS.PaymentResponse> getPaymentsByAmountRange(BigDecimal minAmount, BigDecimal maxAmount) {
        return paymentRepository.findByAmountRangeAndNotDeleted(minAmount, maxAmount).stream()
                .map(this::convertToPaymentResponse)
                .collect(Collectors.toList());
    }

    public Optional<PaymentDTOS.PaymentResponse> updatePayment(Long id, PaymentDTOS.UpdatePaymentRequest request) {
        return paymentRepository.findById(id).map(payment -> {
            UserModel paidBy = userRepository.findById(request.getPaidBy()).orElseThrow();
            BookingModel paidTo = bookingRepository.findById(request.getPaidTo()).orElseThrow();

            payment.setDeleteStatus(request.getDeleteStatus());
            payment.setStatus(request.getStatus());
            payment.setAmount(request.getAmount());
            payment.setMethod(request.getMethod());
            payment.setPaidBy(paidBy);
            payment.setPaidTo(paidTo);

            PaymentModel updatedPayment = paymentRepository.save(payment);
            return convertToPaymentResponse(updatedPayment);
        });
    }

    public boolean deletePayment(Long id) {
        if (paymentRepository.existsById(id)) {
            paymentRepository.deleteById(id);
            return true;
        }
        return false;
    }

    private PaymentDTOS.PaymentResponse convertToPaymentResponse(PaymentModel payment) {
        return new PaymentDTOS.PaymentResponse(
                payment.getId(),
                payment.getDeleteStatus(),
                payment.getStatus(),
                payment.getAmount(),
                payment.getMethod(),
                payment.getPaidBy().getId(),
                payment.getPaidBy().getFirstName() + " " + payment.getPaidBy().getLastName(),
                payment.getPaidBy().getEmail(),
                payment.getPaidTo().getId(),
                payment.getPaidTo().getBookingDate().toString()

        );
    }
}