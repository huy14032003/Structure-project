package com.foxconn.fii.main.data.primary.repository;

import com.foxconn.fii.main.data.primary.dto.response.OrderSummaryRes;
import com.foxconn.fii.main.data.primary.model.entity.Order;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

public interface OrderRepository extends JpaRepository<Order, Long> {

    Page<Order> findByCreateBy(String createBy, Pageable pageable);

}
