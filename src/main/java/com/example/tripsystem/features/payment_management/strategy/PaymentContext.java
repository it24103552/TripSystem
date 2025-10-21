package com.example.tripsystem.features.payment_management.strategy;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Component
public class PaymentContext {
    private PaymentStrategy paymentStrategy;

    @Autowired
    private List<PaymentStrategy> availableStrategies;
    public void setPaymentStrategy(String paymentMethodType) {
        this.paymentStrategy = findStrategyByType(paymentMethodType)
                .orElseThrow(() -> new IllegalArgumentException(
                        "Unsupported payment method: " + paymentMethodType
                ));
    }

    public String executePayment(BigDecimal amount, String paymentDetails) {
        if (paymentStrategy == null) {
            throw new IllegalStateException("Payment strategy not set. Call setPaymentStrategy first.");
        }
        return paymentStrategy.processPayment(amount, paymentDetails);
    }

    public List<String> getAvailablePaymentMethods() {
        return availableStrategies.stream()
                .map(PaymentStrategy::getPaymentMethodType)
                .distinct()
                .toList();
    }

    private Optional<PaymentStrategy> findStrategyByType(String paymentMethodType) {
        return availableStrategies.stream()
                .filter(strategy -> strategy.getPaymentMethodType().equalsIgnoreCase(paymentMethodType))
                .findFirst();
    }
}


