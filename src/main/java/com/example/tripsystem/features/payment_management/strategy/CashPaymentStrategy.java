package com.example.tripsystem.features.payment_management.strategy;

import org.springframework.stereotype.Component;
import java.math.BigDecimal;

@Component
public class CashPaymentStrategy implements PaymentStrategy {

    @Override
    public String processPayment(BigDecimal amount, String paymentDetails) {
        return String.format(
                "Cash payment of $%s recorded successfully. Please ensure cash is collected upon service delivery.",
                amount.toString()
        );
    }

    @Override
    public String getPaymentMethodType() {
        return "CASH";
    }
}