package com.foxconn.fii.main.controller.rest;

import com.foxconn.fii.common.response.CommonResponse;
import com.foxconn.fii.common.response.ListResponse;
import com.foxconn.fii.main.data.primary.dto.response.FormRes;
import com.foxconn.fii.main.data.primary.dto.response.FormResDrop;
import com.foxconn.fii.main.service.FormService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("api/v1/form")
@RequiredArgsConstructor
public class FormController {

    private final FormService formService;

    @GetMapping("{id}")
    public CommonResponse<FormRes> getForm(@PathVariable("id") Long formId,
                                           @RequestParam(required = false) Long segmentId){
        return CommonResponse.success(formService.getForm(formId, segmentId));
    }

    @GetMapping("/forms")
    public ListResponse<FormResDrop> getAllForms() {
        return ListResponse.success(formService.getAllForm());
    }

}
