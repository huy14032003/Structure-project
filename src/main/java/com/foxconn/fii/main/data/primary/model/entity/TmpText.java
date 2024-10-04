package com.foxconn.fii.main.data.primary.model.entity;

import lombok.Data;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import javax.persistence.*;
import java.util.Date;

@Data
@Entity
@Table(name = "tmp_text")
public class TmpText {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "cn_text")
    private String cnText;

    @Column(name = "en_text")
    private String enText;

    @Column(name = "vn_text")
    private String vnText;

    @Column(name = "file_name")
    private String fileName;

    @Column(name = "sheet_name")
    private String sheetName;

    @CreationTimestamp
    @Column(name = "created_at")
    private Date createdAt;

    @UpdateTimestamp
    @Column(name = "updated_at")
    private Date updatedAt;

}
