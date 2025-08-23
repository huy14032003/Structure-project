package com.foxconn.fii.main.data.primary.model.entity;

import com.fasterxml.jackson.annotation.JsonManagedReference;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import com.fasterxml.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Builder
@Table(name = "form")
public class Form implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;

    private String status;

    @CreationTimestamp
    @Column(name = "create_at")
    private LocalDateTime createAt;

    @Column(name = "update_at")
    @UpdateTimestamp
    private LocalDateTime updateAt;

    @OneToMany(mappedBy = "form", fetch = FetchType.LAZY)
    @JsonManagedReference(value = "form-segment")
    private List<Segment> segments;

    @OneToMany(mappedBy = "form", fetch = FetchType.LAZY)
    @JsonManagedReference(value = "form-attribute")
    private List<Attribute> attributes;

    @OneToMany(mappedBy = "order", fetch = FetchType.LAZY)
    @JsonManagedReference(value = "form-log")
    private List<OrderLog> orderLogs;

    @OneToMany(mappedBy = "form", fetch = FetchType.LAZY)
    @JsonManagedReference(value = "order-form")
    private List<Order> orders;
}
