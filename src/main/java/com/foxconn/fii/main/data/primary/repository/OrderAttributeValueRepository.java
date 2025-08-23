package com.foxconn.fii.main.data.primary.repository;

import com.foxconn.fii.main.data.primary.model.entity.OrderAttributeValue;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderAttributeValueRepository extends JpaRepository<OrderAttributeValue, Long> {
}
