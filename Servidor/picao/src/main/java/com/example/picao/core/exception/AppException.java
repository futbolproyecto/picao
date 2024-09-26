package com.example.picao.core.exception;

import com.example.picao.core.util.ErrorMessages;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class AppException extends RuntimeException {
    private final ErrorMessages errorMessages;
    private final HttpStatus httpStatus;



    public AppException(ErrorMessages errorMessages, HttpStatus httpStatus) {
        super(errorMessages.getMessage());
        this.errorMessages = errorMessages;
        this.httpStatus = httpStatus;

    }
}
