package com.foxconn.fii.main.data.primary.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "attribute_value_log")
@Entity
@Builder
public class AttributeValueLog implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "attribute_value_id")
    @JsonBackReference(value = "attribute-value-log")
    private AttributeValue attributeValue;

    @OneToMany(mappedBy = "attributeValueLog")
    @JsonManagedReference(value = "order-attribute-value-log")
    private List<OrderLog> orderLogs;


    @Column(name = "old_value")
    private String oldValue;

    @Column(name = "new_value")
    private String newValue;

    @Column(name = "change_at")
    private LocalDateTime changeAt;

    @Column(name = "change_by")
    private String changeBy;

    private String reason;
}
