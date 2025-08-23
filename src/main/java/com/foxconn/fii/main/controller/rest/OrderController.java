package com.foxconn.fii.main.controller.rest;


import com.foxconn.fii.common.response.CommonResponse;
import com.foxconn.fii.main.data.primary.dto.request.AttributeValueReq;
import com.foxconn.fii.main.data.primary.dto.request.OrderReq;
import com.foxconn.fii.main.data.primary.dto.request.UpdateOrderReq;
import com.foxconn.fii.main.data.primary.dto.response.OrderRes;
import com.foxconn.fii.main.data.primary.model.entity.Order;
import com.foxconn.fii.main.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/order")
@RequiredArgsConstructor
public class OrderController {

    private final OrderService orderService;


    @PostMapping()
    public CommonResponse<Order> createOrder (@RequestBody OrderReq request) {
        Order order = orderService.createOrder(request);
        return CommonResponse.success(order);
    }

    @PutMapping("/{orderId}")
    public CommonResponse<OrderRes> updateOrder(@PathVariable("orderId") Long orderId,
                                                @RequestBody UpdateOrderReq newRequest) {
        OrderRes order = orderService.updateOrder(orderId, newRequest);
        return CommonResponse.success(order);
    }

}
