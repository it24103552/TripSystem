package com.example.tripsystem.features.guide_schedule_management;

import jakarta.persistence.*;
import com.example.tripsystem.features.user_management.UserModel;
import com.example.tripsystem.features.booking_management.BookingModel;

@Entity
@Table(name = "guide_schedules")
public class GuideScheduleModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "guide_id", nullable = false)
    private UserModel guide;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "booking_id", nullable = false)
    private BookingModel booking;

    public GuideScheduleModel() {}

    public GuideScheduleModel(UserModel guide, BookingModel booking) {
        this.guide = guide;
        this.booking = booking;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public UserModel getGuide() {
        return guide;
    }

    public void setGuide(UserModel guide) {
        this.guide = guide;
    }

    public BookingModel getBooking() {
        return booking;
    }

    public void setBooking(BookingModel booking) {
        this.booking = booking;
    }
}