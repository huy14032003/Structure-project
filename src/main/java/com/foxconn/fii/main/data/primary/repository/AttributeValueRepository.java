package com.foxconn.fii.main.data.primary.repository;

import com.foxconn.fii.main.data.primary.model.entity.Attribute;
import com.foxconn.fii.main.data.primary.model.entity.AttributeValue;
import com.foxconn.fii.main.data.primary.model.entity.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface AttributeValueRepository extends JpaRepository<AttributeValue, Long> {

    @Query("SELECT av FROM AttributeValue av " +
            "JOIN av.orders oav " +
            "WHERE oav.order.id = :orderId AND av.attribute = :attribute")
    Optional<AttributeValue> findByOrderIdAndAttribute(@Param("orderId") Long orderId,
                                                       @Param("attribute") Attribute attribute);

    List<AttributeValue> findAllByOrders_Order_Id(Long orderId);
}
