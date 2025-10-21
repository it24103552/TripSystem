package com.example.tripsystem.features.booking_management;

import com.example.tripsystem.features.user_management.UserModel;
import jakarta.persistence.*;

import java.time.LocalDate;
@Entity
@Table(name = "bookings")
public class BookingModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "booking_date", nullable = false)
    private LocalDate bookingDate;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "customer_id", nullable = false)
    private UserModel customer;

    @Column(name = "additional_notes", columnDefinition = "TEXT")
    private String additionalNotes;

    @Column(name = "status", nullable = false)
    private String status;

    public BookingModel() {}

    public BookingModel(LocalDate bookingDate, UserModel customer, String additionalNotes) {
        this.bookingDate = bookingDate;
        this.customer = customer;
        this.additionalNotes = additionalNotes;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDate getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(LocalDate bookingDate) {
        this.bookingDate = bookingDate;
    }

    public UserModel getCustomer() {
        return customer;
    }

    public void setCustomer(UserModel customer) {
        this.customer = customer;
    }

    public String getAdditionalNotes() {
        return additionalNotes;
    }

    public void setAdditionalNotes(String additionalNotes) {
        this.additionalNotes = additionalNotes;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}