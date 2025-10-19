package com.example.tripsystem.features.guide_schedule_management;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;

@Repository
public interface GuideScheduleRepository extends JpaRepository<GuideScheduleModel, Long> {
    List<GuideScheduleModel> findByGuideId(Long guideId);
    List<GuideScheduleModel> findAll();
    Optional<GuideScheduleModel> findById(Long id);
    boolean existsById(Long id);
}