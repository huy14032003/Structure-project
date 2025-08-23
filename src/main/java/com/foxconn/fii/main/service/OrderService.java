package com.foxconn.fii.main.service;

import com.foxconn.fii.main.data.primary.dto.request.OrderReq;
import com.foxconn.fii.main.data.primary.dto.request.UpdateOrderReq;
import com.foxconn.fii.main.data.primary.dto.response.OrderDetailRes;
import com.foxconn.fii.main.data.primary.dto.response.OrderRes;
import com.foxconn.fii.main.data.primary.dto.response.OrderSummaryRes;
import com.foxconn.fii.main.data.primary.model.entity.Order;
import org.springframework.data.domain.Page;

public interface OrderService {
    Order createOrder(OrderReq request);

    OrderRes updateOrder(Long orderId, UpdateOrderReq newRequest);

    Page<OrderSummaryRes> getOrderByUser(String idCard, Integer pageNumber, Integer pageSize);

    OrderDetailRes getOrderById(Long orderId);



}
