package com.foxconn.fii.main.data.primary.model.entity;

import lombok.Data;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Data
@Entity
@Table(name = "mfAgileSOPMapping")
@IdClass(SopAgile.SopAgileKey.class)
public class SopAgile {

    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer item_id;

    @Id
    @Column(name = "change_id")
    private Integer changeId;

    @Id
    @Column(name = "Agile_File_Name")
    private Integer agileFileName;

    @Column(name = "File_type")
    private String fileType;

    @Column(name = "File_Size")
    private Integer fileSize;

    @Column(name = "ITEM_number")
    private String itemNumber;

    @Id
    @Column(name = "Rev")
    private String Rev;

    @Column(name = "lasteditby")
    private String lastEditBy;

    @Column(name = "lasteditdt")
    private Date lastEditDt;

    @Column(name = "File_name")
    private String fileName;

    @Column(name = "skuno")
    private String skuNo;

    @Column(name = "worksection")
    private String workSection;

    @Column(name = "tempflag")
    private String tempFlag;

    @Column(name = "checked_message")
    private String checkedMessage = "";

    @Column(name = "site")
    private String site;


    public String getFileName() {
        return fileName.replace("?", "");
    }

    @Data
    public static class SopAgileKey implements Serializable {

        private Integer changeId;

        private Integer agileFileName;

        private String Rev;
    }
}
