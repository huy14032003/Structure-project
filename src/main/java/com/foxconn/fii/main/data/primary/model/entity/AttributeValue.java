package com.foxconn.fii.main.data.primary.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.codehaus.jackson.annotate.JsonManagedReference;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Builder
@Table(name = "attribute_value")
public class AttributeValue implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "attribute_id")
    @JsonBackReference(value = "attribute-value")
    private Attribute attribute;

    @Column(name = "entity_value")
    private String entityValue;

    @OneToMany(mappedBy = "attributeValue")
    @JsonManagedReference(value = "attribute-value-log")
    private List<AttributeValueLog> attributeValueLogs;

    @OneToMany(mappedBy = "attributeValue")
    @JsonManagedReference(value = "order-attribute-value")
    private List<OrderAttributeValue> orders;

}
