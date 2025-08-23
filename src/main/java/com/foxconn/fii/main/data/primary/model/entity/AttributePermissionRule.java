package com.foxconn.fii.main.data.primary.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "attribute_permission_rule")
public class AttributePermissionRule implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JsonBackReference(value = "user-rule")
    private User user;

    @ManyToOne
    @JsonBackReference(value = "attribute-rule")
    private Attribute attribute;

    @Column(name = "permission_type")
    private String permissionType;

}
