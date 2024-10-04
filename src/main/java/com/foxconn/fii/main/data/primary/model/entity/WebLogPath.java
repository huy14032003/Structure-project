//package com.foxconn.fii.main.data.primary.model.entity;
//
//import lombok.Data;
//import org.hibernate.annotations.CreationTimestamp;
//import org.hibernate.annotations.UpdateTimestamp;
//
//import javax.persistence.*;
//import java.util.Date;
//
//@Data
//@Entity
//@Table(name = "v2_web_log_path")
//public class WebLogPath {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private int id;
//
//    @Column(name = "log_path")
//    private String logPath;
//
//    /** 0: read error | 1: read done */
//    @Column(name="status")
//    private int status = 0;
//
//    @CreationTimestamp
//    @Column(name = "created_at")
//    private Date createdAt;
//
//    @UpdateTimestamp
//    @Column(name = "updated_at")
//    private Date updatedAt;
//
//}
