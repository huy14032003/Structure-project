package com.foxconn.fii.main.data.primary.model.entity;

import com.fasterxml.jackson.annotation.*;
import com.foxconn.fii.main.data.primary.common.StatusOrder;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Table(name = "[order]")
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class Order implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "form_id")
    @JsonBackReference(value = "order-form")
    private Form form;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "current_segment_id")
    @JsonBackReference(value = "order-segment")
    private Segment currentSegment;

    @OneToMany(mappedBy = "order",fetch = FetchType.LAZY)
    @JsonManagedReference(value = "order-attribute")
    private List<OrderAttributeValue> attributeValues;

    @OneToMany(mappedBy = "order",fetch = FetchType.LAZY)
    @JsonManagedReference(value = "order-mail")
    private List<EmailHistory> emailHistories;

    @OneToMany(mappedBy = "order",fetch = FetchType.LAZY)
    @JsonManagedReference(value = "order_log")
    private List<OrderLog> orderLogs;

    private String remark;

    @Enumerated(EnumType.STRING)
    private StatusOrder status;

    @CreationTimestamp
    @Column(name = "create_at", updatable = false)
    private LocalDateTime createAt;

    @UpdateTimestamp
    @Column(name = "update_at")
    private LocalDateTime updateAt;

    @Column(name = "create_by")
    private String createBy;
}
