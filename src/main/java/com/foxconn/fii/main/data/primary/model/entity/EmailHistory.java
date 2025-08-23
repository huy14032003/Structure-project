package com.foxconn.fii.main.data.primary.model.entity;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.foxconn.fii.main.data.primary.common.StatusEmail;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "email_history")
@Builder
public class EmailHistory implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Enumerated(EnumType.STRING)
    private StatusEmail status;

    @CreationTimestamp
    @Column(name = "send_at")
    private LocalDateTime sendAt;

    @ManyToOne
    @JoinColumn(name = "order_id")
    @JsonBackReference(value = "order-mail")
    private Order order;

    @ManyToOne
    @JoinColumn(name = "segment_id")
    @JsonBackReference(value = "segment-mail")
    private Segment segment;

    @ManyToOne
    @JoinColumn(name = "recipient_id")
    @JsonBackReference(value = "recipient-mail")
    private User recipient;

}
