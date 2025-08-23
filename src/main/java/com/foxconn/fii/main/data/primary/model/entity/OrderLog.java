package com.foxconn.fii.main.data.primary.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.foxconn.fii.main.data.primary.common.StatusOrderLog;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.codehaus.jackson.annotate.JsonManagedReference;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "order_log")
@Builder
public class OrderLog implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "order_id")
    @JsonBackReference(value = "order-log")
    private Order order;

    @ManyToOne
    @JoinColumn(name = "attribute_value_log_id")
    @JsonBackReference(value = "order-attribute-value-log")
    private AttributeValueLog attributeValueLog;

    @Column(name = "[type]")
    @Enumerated(EnumType.STRING)
    private StatusOrderLog type;

    @CreationTimestamp
    @Column(name = "create_at")
    private LocalDateTime createAt;

    @Column(name = "create_by")
    private String createBy;

    @Column(name = "update_at")
    @UpdateTimestamp
    private LocalDateTime updateAt;

}
