package com.example.tripsystem.features.payment_management;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Repository
public interface PaymentRepository extends JpaRepository<PaymentModel, Long> {

    List<PaymentModel> findByPaidById(Long paidById);

    Optional<PaymentModel> findByPaidToId(Long paidToId);

    List<PaymentModel> findByDeleteStatusFalse();

    List<PaymentModel> findByPaidByIdAndDeleteStatusFalse(Long paidById);

    List<PaymentModel> findByStatus(String status);

    List<PaymentModel> findByStatusAndDeleteStatusFalse(String status);

    List<PaymentModel> findByMethod(String method);

    List<PaymentModel> findByMethodAndDeleteStatusFalse(String method);

    @Query("SELECT p FROM PaymentModel p WHERE p.amount >= :minAmount AND p.deleteStatus = false")
    List<PaymentModel> findByMinAmountAndNotDeleted(@Param("minAmount") BigDecimal minAmount);

    @Query("SELECT p FROM PaymentModel p WHERE p.amount <= :maxAmount AND p.deleteStatus = false")
    List<PaymentModel> findByMaxAmountAndNotDeleted(@Param("maxAmount") BigDecimal maxAmount);

    @Query("SELECT p FROM PaymentModel p WHERE p.amount BETWEEN :minAmount AND :maxAmount AND p.deleteStatus = false")
    List<PaymentModel> findByAmountRangeAndNotDeleted(@Param("minAmount") BigDecimal minAmount, @Param("maxAmount") BigDecimal maxAmount);
}