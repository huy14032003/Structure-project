package com.foxconn.fii.main.data.primary.repository;

import com.foxconn.fii.main.data.primary.model.entity.AttributeValueLog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AttributeValueLogRepository extends JpaRepository<AttributeValueLog, Long> {
}
