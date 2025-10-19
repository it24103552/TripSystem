package com.example.tripsystem.features.guide_schedule_management;

import com.example.tripsystem.features.user_management.UserModel;
import com.example.tripsystem.features.user_management.UserRepository;
import com.example.tripsystem.features.booking_management.BookingModel;
import com.example.tripsystem.features.booking_management.BookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class GuideScheduleService {

    @Autowired
    private GuideScheduleRepository guideScheduleRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BookingRepository bookingRepository;

    public GuideScheduleDTOS.GuideScheduleResponse createGuideSchedule(GuideScheduleDTOS.CreateGuideScheduleRequest request) {
        UserModel guide = userRepository.findById(request.getGuideId()).orElseThrow(() -> new RuntimeException("Guide not found"));
        BookingModel booking = bookingRepository.findById(request.getBookingId()).orElseThrow(() -> new RuntimeException("Booking not found"));

        GuideScheduleModel schedule = new GuideScheduleModel(guide, booking);
        GuideScheduleModel savedSchedule = guideScheduleRepository.save(schedule);
        return convertToResponse(savedSchedule);
    }

    public Optional<GuideScheduleDTOS.GuideScheduleResponse> getGuideScheduleById(Long id) {
        return guideScheduleRepository.findById(id).map(this::convertToResponse);
    }

    public List<GuideScheduleDTOS.GuideScheduleResponse> getAllGuideSchedules() {
        return guideScheduleRepository.findAll().stream()
                .map(this::convertToResponse)
                .collect(Collectors.toList());
    }

    public List<GuideScheduleDTOS.GuideScheduleResponse> getGuideSchedulesByGuideId(Long guideId) {
        return guideScheduleRepository.findByGuideId(guideId).stream()
                .map(this::convertToResponse)
                .collect(Collectors.toList());
    }

    public Optional<GuideScheduleDTOS.GuideScheduleResponse> updateGuideSchedule(Long id, GuideScheduleDTOS.UpdateGuideScheduleRequest request) {
        return guideScheduleRepository.findById(id).map(schedule -> {
            UserModel guide = userRepository.findById(request.getGuideId()).orElseThrow(() -> new RuntimeException("Guide not found"));
            BookingModel booking = bookingRepository.findById(request.getBookingId()).orElseThrow(() -> new RuntimeException("Booking not found"));

            schedule.setGuide(guide);
            schedule.setBooking(booking);
            GuideScheduleModel updatedSchedule = guideScheduleRepository.save(schedule);
            return convertToResponse(updatedSchedule);
        });
    }

    public boolean deleteGuideSchedule(Long id) {
        if (guideScheduleRepository.existsById(id)) {
            guideScheduleRepository.deleteById(id);
            return true;
        }
        return false;
    }

    private GuideScheduleDTOS.GuideScheduleResponse convertToResponse(GuideScheduleModel schedule) {
        UserModel guide = schedule.getGuide();
        BookingModel booking = schedule.getBooking();
        return new GuideScheduleDTOS.GuideScheduleResponse(
                schedule.getId(),
                guide.getId(),
                guide.getFirstName() + " " + guide.getLastName(),
                guide.getEmail(),
                booking.getId(),
                booking.getBookingDate()
        );
    }
}