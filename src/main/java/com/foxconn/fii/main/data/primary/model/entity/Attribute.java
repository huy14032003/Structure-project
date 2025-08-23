package com.foxconn.fii.main.data.primary.model.entity;

import com.fasterxml.jackson.annotation.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "[attribute]")
@Builder
public class Attribute implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String code;

    @Column(name = "display_name")
    private String displayName;

    @JoinColumn(name = "segment_id")
    @JsonBackReference(value = "segment-attribute")
    @ManyToOne(fetch = FetchType.LAZY)
    private Segment segment;

    @JoinColumn(name = "form_id")
    @JsonBackReference(value = "form-attribute")
    @ManyToOne(fetch = FetchType.LAZY)
    private Form form;

    @Column(name = "[type]")
    private String type;

    private String entity;

    @Column(name = "[filter]")
    private String filter;

    @OneToMany(mappedBy = "attribute", fetch = FetchType.LAZY)
    @JsonManagedReference(value = "attribute-value")
    List<AttributeValue> attributeValues;


    @OneToMany(mappedBy = "attribute", fetch = FetchType.LAZY)
    @JsonManagedReference(value = "attribute-rule")
    List<AttributePermissionRule> attributePermissionRules;
}
