package com.example.picao.core.exception;

import com.example.picao.core.util.ErrorMessages;
import lombok.Getter;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;

@Getter
public class AppException extends RuntimeException {
    private final ErrorMessages errorMessages;
    private final HttpStatus httpStatus;



    public AppException(ErrorMessages errorMessages, HttpStatus httpStatus) {
        super(errorMessages.getMessage());
        this.errorMessages = errorMessages;
        this.httpStatus = getHttpStatus();

    }
}
