package com.foxconn.fii.main.data.primary.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class AttributeValueRes implements Serializable {

    private Long id;

    private Long attributeId;

    private String value;
}
