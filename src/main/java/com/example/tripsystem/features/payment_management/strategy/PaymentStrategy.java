package com.example.tripsystem.features.payment_management.strategy;

import java.math.BigDecimal;

public interface PaymentStrategy {
    String processPayment(BigDecimal amount, String paymentDetails);
    String getPaymentMethodType();
}
