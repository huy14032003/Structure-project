package com.foxconn.fii.main.data.primary.model.entity;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import javax.persistence.*;
import java.util.Date;

@Slf4j
@Data
//@Entity
//@Table(name = "security_media")
public class TmpMedia {

//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

//    @Column(name = "name", unique = true)
    private String name;

//    @Column(name = "original_name")
    private String originalName;

//    @Column(name = "hash_sha256")
    private String hashSHA256;

//    @Column(name = "size")
    private Long size;

//    @Column(name = "path")
    private String path;

//    @Column(name = "url")
    private String url;

//    @Column(name = "type")
    private String type;

//    @Column(name = "where_used")
    private String whereUsed;


//    @Column(name = "active_flag", columnDefinition = "TINYINT(1)")
    private boolean activeFlag = false;

//    @CreationTimestamp
//    @Column(name = "created_at")
    private Date createdAt = new Date();

//    @UpdateTimestamp
//    @Column(name = "updated_at")
    private Date updatedAt = new Date();

}
