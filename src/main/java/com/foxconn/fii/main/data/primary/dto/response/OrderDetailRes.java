package com.foxconn.fii.main.data.primary.dto.response;
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
public class OrderDetailRes implements Serializable {

    private Long id;

    private String remark;

    private String status;

    private LocalDateTime createAt;

    private LocalDateTime updateAt;

    private String createBy;

    private FormDetailRes form;
}
