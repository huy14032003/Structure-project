package com.foxconn.fii.main.data.primary.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AttributeValueReq implements Serializable {

    private Long attributeId;

    private String value;

    private String reason;

}
