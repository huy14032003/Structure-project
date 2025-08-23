package com.foxconn.fii.main.service;

import com.foxconn.fii.main.data.primary.dto.request.OrderReq;
import com.foxconn.fii.main.data.primary.dto.request.UpdateOrderReq;
import com.foxconn.fii.main.data.primary.dto.response.OrderRes;
import com.foxconn.fii.main.data.primary.model.entity.Order;

public interface OrderService {
    Order createOrder(OrderReq request);

    OrderRes updateOrder(Long orderId, UpdateOrderReq newRequest);

}
