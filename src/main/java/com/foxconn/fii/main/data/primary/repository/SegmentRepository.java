package com.foxconn.fii.main.data.primary.repository;

import com.foxconn.fii.main.data.primary.model.entity.Segment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface SegmentRepository extends JpaRepository<Segment, Long> {

    Optional<Segment> findByIdAndFormId(@Param("id") Long id,
                                        @Param("formId") Long formId);

    Optional<Segment> findFirstByFormIdOrderByIndexAsc(@Param("formId") Long formId);

}
