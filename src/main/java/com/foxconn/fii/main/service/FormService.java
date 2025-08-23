package com.foxconn.fii.main.service;

import com.foxconn.fii.main.data.primary.dto.response.FormRes;
import com.foxconn.fii.main.data.primary.dto.response.FormResDrop;

import java.util.List;

public interface FormService {

    FormRes getForm(Long formId, Long segmentId);

    List<FormResDrop> getAllForm();
}
