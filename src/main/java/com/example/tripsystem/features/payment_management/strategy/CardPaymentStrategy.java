package com.example.tripsystem.features.payment_management.strategy;

import org.springframework.stereotype.Component;
import java.math.BigDecimal;

@Component
public class CardPaymentStrategy implements PaymentStrategy {

    @Override
    public String processPayment(BigDecimal amount, String paymentDetails) {
        String maskedCard = maskCardNumber(paymentDetails);
        String transactionId = generateTransactionId();

        return String.format(
                "Card payment of $%s processed successfully using card: %s. Transaction ID: %s",
                amount.toString(), maskedCard, transactionId
        );
    }

    @Override
    public String getPaymentMethodType() {
        return "CARD";
    }

    private String maskCardNumber(String cardNumber) {
        if (cardNumber == null || cardNumber.length() <= 4) {
            return "****";
        }
        return "****-****-****-" + cardNumber.substring(cardNumber.length() - 4);
    }

    private String generateTransactionId() {
        return "TXN" + System.currentTimeMillis();
    }
}


