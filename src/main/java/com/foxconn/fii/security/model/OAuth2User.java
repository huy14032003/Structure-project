package com.foxconn.fii.security.model;

import lombok.Data;

@Data
public class OAuth2User {

    private String username;


    private String name;

    private String chineseName;

    private String email;

    private String avatar;

    private String title;

    private Integer level;


    private String ouCode;

    private String ouName;

    private String upperOuCode;

    private String lowerOuCode;


    private String area;

    private String subArea;

    private String factory;

    private String floor;


    private String businessGroup;

    private String legalPerson;

    private String bu;

    private String cft;

    private String department;


    private String allManagers;

    private String siteAllManagers;

    private String buAllManagers;

    private String assistant;
}
