package com.foxconn.fii.main.data.primary.dto.response;

import com.foxconn.fii.main.data.primary.common.StatusOrder;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class OrderRes implements Serializable {

    private Long id;

    private List<AttributeValueRes> attributeValues;

    private String remark;

    private StatusOrder status;
}
