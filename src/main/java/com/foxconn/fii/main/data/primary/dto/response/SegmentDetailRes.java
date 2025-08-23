package com.foxconn.fii.main.data.primary.dto.response;

import com.fasterxml.jackson.annotation.JsonInclude;
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
@JsonInclude(JsonInclude.Include.NON_EMPTY)
public class SegmentDetailRes implements Serializable {

    private Long id;

    private String name;

    private Integer index;

    private List<AttributeDetailRes> attributes;
}
