package com.foxconn.fii.common.response;

import lombok.Value;
import org.springframework.http.HttpStatus;

@Value(staticConstructor = "of")
public class CommonResponse<T> {

    private HttpStatus status;

    private ResponseCode code;

    private String message;

    private T result;

    public static <T> CommonResponse<T> success(T data) {
        return CommonResponse.of(HttpStatus.OK, ResponseCode.SUCCESS, "success", data);
    }

    public static <T> CommonResponse<T> fail(String message, T data) {
        return CommonResponse.of(HttpStatus.OK, ResponseCode.FAILED, message, data);
    }

    public static <T> CommonResponse<T> notFound(String message, T data) {
        return CommonResponse.of(HttpStatus.NOT_FOUND, ResponseCode.FAILED, message, data);
    }

}
