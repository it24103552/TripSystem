package com.example.tripsystem.features.payment_management;

import com.example.tripsystem.features.user_management.UserModel;
import com.example.tripsystem.features.booking_management.BookingModel;
import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "payments")
public class PaymentModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "delete_status", nullable = false)
    private Boolean deleteStatus;

    @Column(name = "status", nullable = false)
    private String status;

    @Column(name = "amount", nullable = false, precision = 10, scale = 2)
    private BigDecimal amount;

    @Column(name = "method", nullable = false)
    private String method;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "paid_by", nullable = false)
    private UserModel paidBy;

    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "paid_to", nullable = false)
    private BookingModel paidTo;

    public PaymentModel() {}

    public PaymentModel(Boolean deleteStatus, String status, BigDecimal amount, String method, UserModel paidBy, BookingModel paidTo) {
        this.deleteStatus = deleteStatus;
        this.status = status;
        this.amount = amount;
        this.method = method;
        this.paidBy = paidBy;
        this.paidTo = paidTo;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Boolean getDeleteStatus() {
        return deleteStatus;
    }

    public void setDeleteStatus(Boolean deleteStatus) {
        this.deleteStatus = deleteStatus;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public UserModel getPaidBy() {
        return paidBy;
    }

    public void setPaidBy(UserModel paidBy) {
        this.paidBy = paidBy;
    }

    public BookingModel getPaidTo() {
        return paidTo;
    }

    public void setPaidTo(BookingModel paidTo) {
        this.paidTo = paidTo;
    }
}