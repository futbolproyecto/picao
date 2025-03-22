package com.example.picao.core.exception;

import com.example.picao.core.util.ErrorMessages;
import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class AppException extends RuntimeException {
    private final ErrorMessages errorMessages;
    private final HttpStatus httpStatus;
    private final transient Object[] args;

    public AppException(ErrorMessages errorMessages, HttpStatus httpStatus, Object... args) {
        super(String.format(errorMessages.getFormattedMessage(args)));
        this.errorMessages = errorMessages;
        this.httpStatus = httpStatus;
        this.args = args; // Guardamos los argumentos
    }
}
