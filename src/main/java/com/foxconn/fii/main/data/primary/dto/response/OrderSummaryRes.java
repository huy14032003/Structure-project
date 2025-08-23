package com.foxconn.fii.main.data.primary.dto.response;

import com.foxconn.fii.main.data.primary.model.entity.Form;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class OrderSummaryRes implements Serializable {

    private Long id;

    private String formName;

    private String remark;

    private String status;

    private LocalDateTime createdAt;

    private String createdBy;

}
