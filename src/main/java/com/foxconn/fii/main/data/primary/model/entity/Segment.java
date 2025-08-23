package com.foxconn.fii.main.data.primary.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "segment")
public class Segment implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "form_id")
    @JsonBackReference(value = "form-segment")
    private Form form;

    private String name;

    @Column(name = "[index]")
    private Integer index;

    @OneToMany(mappedBy = "segment", fetch = FetchType.LAZY)
    @JsonManagedReference(value = "segment-attribute")
    private List<Attribute> attributes;

    @OneToMany(mappedBy = "segment", fetch = FetchType.LAZY)
    @JsonManagedReference(value = "segment-mail")
    private List<EmailHistory> emailHistories;


    @OneToMany(mappedBy = "currentSegment", fetch = FetchType.LAZY)
    @JsonManagedReference(value = "order-segment")
    private List<Order> orders;
}
