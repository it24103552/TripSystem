package com.example.tripsystem.features.booking_management;

import com.example.tripsystem.features.user_management.UserModel;
import com.example.tripsystem.features.user_management.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private UserRepository userRepository;

    public BookingDTOS.BookingResponse createBooking(BookingDTOS.CreateBookingRequest request) {
        UserModel customer = userRepository.findById(request.getCustomerId()).orElseThrow();

        BookingModel booking = new BookingModel(
                request.getBookingDate(),
                customer,
                request.getAdditionalNotes()
        );
        booking.setStatus(request.getStatus());

        BookingModel savedBooking = bookingRepository.save(booking);
        return convertToBookingResponse(savedBooking);
    }

    public Optional<BookingDTOS.BookingResponse> getBookingById(Long id) {
        return bookingRepository.findById(id).map(this::convertToBookingResponse);
    }

    public List<BookingDTOS.BookingResponse> getAllBookings() {
        return bookingRepository.findAll().stream()
                .map(this::convertToBookingResponse)
                .collect(Collectors.toList());
    }

    public List<BookingDTOS.BookingResponse> getBookingsByCustomerId(Long customerId) {
        return bookingRepository.findByCustomerId(customerId).stream()
                .map(this::convertToBookingResponse)
                .collect(Collectors.toList());
    }

    public List<BookingDTOS.BookingResponse> getBookingsByDate(LocalDate date) {
        return bookingRepository.findByBookingDate(date).stream()
                .map(this::convertToBookingResponse)
                .collect(Collectors.toList());
    }

    public Optional<BookingDTOS.BookingResponse> updateBooking(Long id, BookingDTOS.UpdateBookingRequest request) {
        return bookingRepository.findById(id).map(booking -> {
            UserModel customer = userRepository.findById(request.getCustomerId()).orElseThrow();

            booking.setBookingDate(request.getBookingDate());
            booking.setCustomer(customer);
            booking.setAdditionalNotes(request.getAdditionalNotes());
            booking.setStatus(request.getStatus());
            BookingModel updatedBooking = bookingRepository.save(booking);
            return convertToBookingResponse(updatedBooking);
        });
    }

    public boolean deleteBooking(Long id) {
        if (bookingRepository.existsById(id)) {
            bookingRepository.deleteById(id);
            return true;
        }
        return false;
    }

    private BookingDTOS.BookingResponse convertToBookingResponse(BookingModel booking) {
        return new BookingDTOS.BookingResponse(
                booking.getId(),
                booking.getBookingDate(),
                booking.getCustomer().getId(),
                booking.getCustomer().getFirstName() + " " + booking.getCustomer().getLastName(),
                booking.getCustomer().getEmail(),
                booking.getAdditionalNotes(),
                booking.getStatus()
        );
    }
}