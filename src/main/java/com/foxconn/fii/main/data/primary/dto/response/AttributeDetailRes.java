package com.foxconn.fii.main.data.primary.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class AttributeDetailRes implements Serializable {

    private Long id;

    private String code;

    private String displayName;

    private String type;

    private String entity;

    private String value; //lấy value từ attributeValue nếu có
}
