package com.foxconn.fii.main.data.primary.repository;

import com.foxconn.fii.main.data.primary.model.entity.OrderLog;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderLogRepository extends JpaRepository<OrderLog, Long> {
}
