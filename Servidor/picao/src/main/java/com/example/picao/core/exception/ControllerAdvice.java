package com.example.picao.core.exception;

import com.example.picao.core.util.ErrorMessages;
import com.example.picao.core.util.dto.GenericResponseErrorDTO;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;

@RestControllerAdvice
public class ControllerAdvice extends ResponseEntityExceptionHandler {

    @ExceptionHandler(value = RuntimeException.class)
    public ResponseEntity<GenericResponseErrorDTO> exception() {
        return GenericResponseErrorDTO.genericResponseError(
                ErrorMessages.UNHANDLED_ERROR, HttpStatus.BAD_REQUEST);
    }
    @ExceptionHandler(value = AppException.class)
    public ResponseEntity<GenericResponseErrorDTO> requestException(AppException ex) {
        return GenericResponseErrorDTO.genericResponseError(
                ex.getErrorMessages(), HttpStatus.BAD_REQUEST);
    }
}
