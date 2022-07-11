package com.foxconn.fii.common;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;

import javax.persistence.AttributeConverter;
import javax.persistence.Converter;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

@Slf4j
@Converter
public class MapObjectColumnConverter<T> implements AttributeConverter<Map<String, T>, String> {
    private static final ObjectMapper mapper = new ObjectMapper();

    @Override
    public String convertToDatabaseColumn(Map<String, T> stringObject) {
        try {
            return mapper.writeValueAsString(stringObject);
        } catch (JsonProcessingException e) {
            log.error("### convertToDatabaseColumn", e);
            return "";
        }
    }

    @Override
    public Map<String, T> convertToEntityAttribute(String s) {
        try {
            return mapper.readValue(s, new TypeReference<LinkedHashMap<String, T>>(){});
        } catch (IOException e) {
            log.error("### convertToEntityAttribute", e);
            return null;
        }
    }
}
