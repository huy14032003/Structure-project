package com.foxconn.fii.main.service.impl;

import com.foxconn.fii.common.exception.CommonException;
import com.foxconn.fii.main.data.primary.dto.response.AttributeRes;
import com.foxconn.fii.main.data.primary.dto.response.FormRes;
import com.foxconn.fii.main.data.primary.dto.response.FormResDrop;
import com.foxconn.fii.main.data.primary.dto.response.SegmentRes;
import com.foxconn.fii.main.data.primary.model.entity.Form;
import com.foxconn.fii.main.data.primary.model.entity.Segment;
import com.foxconn.fii.main.data.primary.repository.FormRepository;
import com.foxconn.fii.main.data.primary.repository.SegmentRepository;
import com.foxconn.fii.main.service.FormService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class FormServiceImpl implements FormService {

    private final FormRepository formRepository;

    private final SegmentRepository segmentRepository;


    @Override
    public FormRes getForm(Long formId, Long segmentId) {

        if (formId == null) {
            throw CommonException.of("Form id can not be null");
        }

        if (segmentId == null) {
            Form form = formRepository.findById(formId)
                    .orElseThrow(() -> CommonException.of("Form not found!"));
            return mapToFormRes(form);
        }
        else {
            Segment segment = segmentRepository.findByIdAndFormId(formId, segmentId)
                    .orElseThrow(() -> CommonException.of("Segment not found in form!"));
            return mapToFormResWithOneSegment(segment.getForm(), segment);
        }
    }


    private FormRes mapToFormRes(Form form) {
        List<SegmentRes> segmentResList = form
                .getSegments().stream()
                .map(this::mapToSegmentRes)
                .collect(Collectors.toList());

        return new FormRes(form.getId(), form.getName(), segmentResList);
    }

    private FormRes mapToFormResWithOneSegment(Form form, Segment segment) {
        return new FormRes(form.getId(), form.getName(),
                Collections.singletonList(mapToSegmentRes(segment)));
    }


    private SegmentRes mapToSegmentRes(Segment segment) {
        List<AttributeRes> attributes = segment
                .getAttributes()
                .stream()
                .map(a -> new AttributeRes(a.getId(), a.getCode(), a.getDisplayName(), a.getType(), a.getEntity()))
                .collect(Collectors.toList());

        return new SegmentRes(segment.getId(), segment.getName(), segment.getIndex(), attributes);
    }

    @Override
    public List<FormResDrop> getAllForm() {
        List<FormResDrop> forms = formRepository
                .findAll()
                .stream()
                .map(f -> new FormResDrop(f.getId(), f.getName()))
                .collect(Collectors.toList());
        return forms;
    }

}
