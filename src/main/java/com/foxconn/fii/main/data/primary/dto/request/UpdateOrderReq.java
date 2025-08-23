package com.foxconn.fii.main.data.primary.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UpdateOrderReq implements Serializable {

    private String remark;

    private List<AttributeValueReq> attributeValues;

}
