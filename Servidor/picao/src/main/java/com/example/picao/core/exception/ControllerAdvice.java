package com.example.picao.core.exception;

import com.example.picao.core.util.ErrorMessages;
import com.example.picao.core.util.dto.GenericResponseErrorDTO;
import lombok.extern.log4j.Log4j2;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.concurrent.atomic.AtomicReference;

@RestControllerAdvice
@Order(Ordered.HIGHEST_PRECEDENCE)
@Log4j2
public class ControllerAdvice {

    @ExceptionHandler(value = AppException.class)
    public ResponseEntity<GenericResponseErrorDTO> appException(AppException ex) {
        return GenericResponseErrorDTO.genericResponseError(
                ex.getErrorMessages(), HttpStatus.BAD_REQUEST, ex.getArgs());
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ResponseEntity<GenericResponseErrorDTO> handleMethodArgumentNotValidException(MethodArgumentNotValidException ex) {
        AtomicReference<String> errors = new AtomicReference<>("");
        ex.getBindingResult().getAllErrors().forEach(error -> {
            String fieldName = ((FieldError) error).getField();
            String errorMessage = error.getDefaultMessage();
            errors.set(String.format("%s %s", fieldName, errorMessage));
        });

        return GenericResponseErrorDTO.formResponseError(errors.get(), HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(value = RuntimeException.class)
    public ResponseEntity<GenericResponseErrorDTO> exception(RuntimeException e) {
        log.error(e.getMessage());
        e.printStackTrace();
        return GenericResponseErrorDTO.genericResponseError(
                ErrorMessages.UNHANDLED_ERROR, HttpStatus.BAD_REQUEST);
    }


}
