package com.foxconn.fii.main.service.impl;

import com.foxconn.fii.common.exception.CommonException;
import com.foxconn.fii.main.data.primary.common.StatusOrder;
import com.foxconn.fii.main.data.primary.common.StatusOrderLog;
import com.foxconn.fii.main.data.primary.dto.request.AttributeValueReq;
import com.foxconn.fii.main.data.primary.dto.request.OrderReq;
import com.foxconn.fii.main.data.primary.dto.request.UpdateOrderReq;
import com.foxconn.fii.main.data.primary.model.entity.*;
import com.foxconn.fii.main.data.primary.repository.*;
import com.foxconn.fii.main.service.OrderLogService;
import com.foxconn.fii.main.service.OrderService;
import com.foxconn.fii.security.model.OAuth2User;
import com.foxconn.fii.security.service.OAuth2Service;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class OrderServiceImpl implements OrderService {

    private final OrderRepository orderRepository;

    private final FormRepository formRepository;

    private final SegmentRepository segmentRepository;

    private final OAuth2Service oAuth2Service;

    private final OrderLogRepository orderLogRepository;

    private final AttributeRepository attributeRepository;

    private final AttributeValueRepository attributeValueRepository;

    private final OrderAttributeValueRepository orderAttributeValueRepository;

    private final AttributeValueLogRepository attributeValueLogRepository;

    private String getCurrentUsername() {
        return oAuth2Service.getCurrentUser().getUsername();
    }

    @Override
    @Transactional
    public Order createOrder(OrderReq request) {

        if (request.getFormId() == null || request.getRemark() == null || request.getRemark().isEmpty()) {
            throw CommonException.of("Please fill in all required fields!");
        }

        Form form = formRepository.findById(request.getFormId())
                .orElseThrow(() -> CommonException.of("Form not exists!"));

        Segment firstSegment = segmentRepository.findFirstByFormIdOrderByIndexAsc(form.getId())
                .orElseThrow(() -> CommonException.of("Segment not exists!"));

        Order order = Order.builder()
                .form(form)
                .remark(request.getRemark())
                .currentSegment(firstSegment)
                .createAt(LocalDateTime.now())
                .status(StatusOrder.PROCESS)
                .createBy(getCurrentUsername())
                .build();

        Order savedOrder = orderRepository.save(order);

        OrderLog orderLog = OrderLog.builder()
                .order(savedOrder)
                .type(StatusOrderLog.CREATE)
                .createAt(LocalDateTime.now())
                .createBy(getCurrentUsername())
                .build();
        orderLogRepository.save(orderLog);

        return savedOrder;
    }

    @Override
    @Transactional
    public Order updateOrder(Long orderId, UpdateOrderReq newRequest) {

        Order order = orderRepository.findById(orderId)
                .orElseThrow(() -> CommonException.of("Order not found!"));

        // lấy list attributeIds từ request
        List<Long> attributeIds = newRequest.getAttributeValues()
                .stream()
                .map(AttributeValueReq::getAttributeId)
                .collect(Collectors.toList());

        // load tất cả attributes liên quan
        List<Attribute> attributes = attributeRepository.findAllById(attributeIds);
        Map<Long, Attribute> attributeMap = attributes.stream()
                .collect(Collectors.toMap(Attribute::getId, a -> a));

        // load tất cả attributeValue hiện có trong order
        List<AttributeValue> existingValues =
                attributeValueRepository.findAllByOrders_Order_Id(order.getId());

        Map<Long, AttributeValue> attributeValueMap = existingValues.stream()
                .collect(Collectors.toMap(av -> av.getAttribute().getId(), av -> av));

        // duyệt request
        for (AttributeValueReq avg : newRequest.getAttributeValues()) {
            Attribute attribute = attributeMap.get(avg.getAttributeId());
            if (attribute == null) {
                throw CommonException.of("Attribute not found!");
            }

            AttributeValue attributeValue = attributeValueMap.get(avg.getAttributeId());

            if (attributeValue == null) {
                // chưa có → tạo mới
                attributeValue = AttributeValue.builder()
                        .attribute(attribute)
                        .entityValue(avg.getValue())
                        .build();
                attributeValueRepository.save(attributeValue);

                // tạo quan hệ order ↔ attribute_value
                orderAttributeValueRepository.save(OrderAttributeValue.builder()
                        .order(order)
                        .attributeValue(attributeValue)
                        .build());

            } else {
                // đã có → update nếu giá trị thay đổi
                String oldValue = attributeValue.getEntityValue();
                if (!Objects.equals(oldValue, avg.getValue())) {
                    attributeValue.setEntityValue(avg.getValue());
                    attributeValueRepository.save(attributeValue);

                    // log thay đổi attributeValue
                    AttributeValueLog attributeValueLog = AttributeValueLog.builder()
                            .attributeValue(attributeValue)
                            .oldValue(oldValue)
                            .newValue(avg.getValue())
                            .changeAt(LocalDateTime.now())
                            .changeBy(getCurrentUsername())
                            .reason(avg.getReason())
                            .build();
                    attributeValueLogRepository.save(attributeValueLog);

                    // log thay đổi vào order
                    orderLogRepository.save(OrderLog.builder()
                            .order(order)
                            .attributeValueLog(attributeValueLog)
                            .type(StatusOrderLog.UPDATE)
                            .createAt(LocalDateTime.now())
                            .createBy(getCurrentUsername())
                            .build());
                }
            }
        }

        // update remark nếu có
        if (newRequest.getRemark() != null) {
            order.setRemark(newRequest.getRemark());
        }

        return orderRepository.save(order);
    }


}
