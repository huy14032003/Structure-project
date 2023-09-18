package com.foxconn.fii.main.data.primary.model.entity;

import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "v2_web_access_history")
public class WebAccessHistory {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "ip_address")
    private String ipAddress;

    @Column(name = "access_time")
    private String accessTime;

    @Column(name = "process_time")
    private String processTime;

    @Column(name = "url")
    private String url;

    @Column(name = "http_protocol")
    private String httpProtocol;

    @Column(name = "http_methods")
    private String httpMethod;

    @Column(name = "http_status")
    private String httpStatus;

    @Column(name = "source")
    private String source;

    @Column(name = "browser")
    private String browser;

    @Column(name="length")
    private String length;

    @CreationTimestamp
    @Column(name = "created_at")
    private Date createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private Date updatedAt;

}
