package com.example.tripsystem.features.payment_management.strategy;

import org.springframework.stereotype.Component;
import java.math.BigDecimal;

@Component
public class BankTransferPaymentStrategy implements PaymentStrategy {

    @Override
    public String processPayment(BigDecimal amount, String paymentDetails) {
        String reference = paymentDetails != null && !paymentDetails.isEmpty()
                ? paymentDetails
                : generateReference();

        return String.format(
                "Bank transfer of $%s initiated successfully. Reference: %s. Please allow 1-2 business days for processing.",
                amount.toString(), reference
        );
    }

    @Override
    public String getPaymentMethodType() {
        return "BANK_TRANSFER";
    }

    private String generateReference() {
        return "REF" + System.currentTimeMillis();
    }
}


