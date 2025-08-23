package com.foxconn.fii.main.controller.rest;


import com.foxconn.fii.common.response.CommonResponse;
import com.foxconn.fii.common.response.ListResponse;
import com.foxconn.fii.main.data.primary.dto.request.AttributeValueReq;
import com.foxconn.fii.main.data.primary.dto.request.OrderReq;
import com.foxconn.fii.main.data.primary.dto.request.UpdateOrderReq;
import com.foxconn.fii.main.data.primary.dto.response.OrderDetailRes;
import com.foxconn.fii.main.data.primary.dto.response.OrderRes;
import com.foxconn.fii.main.data.primary.dto.response.OrderSummaryRes;
import com.foxconn.fii.main.data.primary.model.entity.Order;
import com.foxconn.fii.main.service.OrderService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
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

    @GetMapping()
    public CommonResponse<Page<OrderSummaryRes>> getOrderByIdCard(@RequestParam(name = "idCard") String idCard,
                                                          @RequestParam(name = "pageNumber", required = false, defaultValue = "1") Integer pageNumber,
                                                          @RequestParam(name = "pageSize", required = false, defaultValue = "10") Integer pageSize) {
        Page<OrderSummaryRes> orderSummaryRes = orderService.getOrderByUser(idCard, pageNumber, pageSize);
        return CommonResponse.success(orderSummaryRes);
    }

    @GetMapping("/{orderId}")
    public CommonResponse<OrderDetailRes> getOrderDetail(@PathVariable(name = "orderId") Long orderId) {
        OrderDetailRes orderDetailRes = orderService.getOrderById(orderId);
        return CommonResponse.success(orderDetailRes);
    }

}
