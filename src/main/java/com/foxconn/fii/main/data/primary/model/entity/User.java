package com.foxconn.fii.main.data.primary.model.entity;

import com.fasterxml.jackson.annotation.*;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Builder
@Table(name = "[user]")
public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;

    private String name;

    @Column(name = "chinese_name")
    private String chineseName;

    private String email;

    @Column(name = "legal_person")
    private String legalPerson;

    @Column(name = "bu_name")
    private String buName;

    @Column(name = "cft_name")
    private String cftName;

    @Column(name = "all_manager")
    private String allManager;

    @ManyToOne
    @JoinColumn(name = "department_id")
    @JsonBackReference(value = "user-department")
    private Department department;

    @OneToMany(mappedBy = "user")
    @JsonManagedReference(value = "user-rule")
    private List<AttributePermissionRule> attributePermissionRules;

    @OneToMany(mappedBy = "recipient")
    @JsonManagedReference(value = "recipient-mail")
    private List<EmailHistory> emailHistories;

}
