package com.example.tripsystem.features.booking_management;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;

@Repository
public interface BookingRepository extends JpaRepository<BookingModel, Long> {

    List<BookingModel> findByCustomerId(Long customerId);

    List<BookingModel> findByBookingDate(LocalDate bookingDate);

    @Query("SELECT b FROM BookingModel b WHERE b.bookingDate BETWEEN :startDate AND :endDate")
    List<BookingModel> findByBookingDateBetween(@Param("startDate") LocalDate startDate, @Param("endDate") LocalDate endDate);
}