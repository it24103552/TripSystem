package com.example.tripsystem.features.feedback_management;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface FeedbackRepository extends JpaRepository<FeedbackModel, Long> {

    List<FeedbackModel> findByUserId(Long userId);

    List<FeedbackModel> findByDeleteStatusFalse();

    List<FeedbackModel> findByUserIdAndDeleteStatusFalse(Long userId);

    List<FeedbackModel> findByNumOfStars(Integer numOfStars);

    List<FeedbackModel> findByNumOfStarsAndDeleteStatusFalse(Integer numOfStars);

    @Query("SELECT f FROM FeedbackModel f WHERE f.numOfStars >= :minStars AND f.deleteStatus = false")
    List<FeedbackModel> findByMinStarsAndNotDeleted(@Param("minStars") Integer minStars);

    @Query("SELECT f FROM FeedbackModel f ORDER BY f.createdAt DESC")
    List<FeedbackModel> findAllOrderByCreatedAtDesc();

    @Query("SELECT f FROM FeedbackModel f WHERE f.deleteStatus = false ORDER BY f.createdAt DESC")
    List<FeedbackModel> findActiveOrderByCreatedAtDesc();
}