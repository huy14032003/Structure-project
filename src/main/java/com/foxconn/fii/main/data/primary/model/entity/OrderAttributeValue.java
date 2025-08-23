package com.foxconn.fii.main.data.primary.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Data
@Table(name = "order_attribute_value")
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderAttributeValue implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "order_id", nullable = false)
    @JsonBackReference(value = "order-attribute")
    private Order order;

    @ManyToOne(fetch = FetchType.LAZY)
    @JsonBackReference(value = "order-attribute-value")
    @JoinColumn(name = "attribute_value_id", nullable = false)
    private AttributeValue attributeValue;
}
