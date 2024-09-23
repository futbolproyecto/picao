package com.example.picao.core.util.dto;

import com.example.picao.core.util.ErrorMessages;
import lombok.Data;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

@Data
public class GenericResponseErrorDTO {
    private Integer status;
    private String error;
    private String recommendation;
    private String code;

    public static ResponseEntity<GenericResponseErrorDTO> genericResponseError(
            ErrorMessages error, HttpStatus status) {

        GenericResponseErrorDTO genericResponseErrorDto = new GenericResponseErrorDTO();
        genericResponseErrorDto.setStatus(status.value());
        genericResponseErrorDto.setError(error.getMessage());
        genericResponseErrorDto.setRecommendation(error.getRecommendation());
        genericResponseErrorDto.setCode(error.getCode());

        return new ResponseEntity<>(genericResponseErrorDto, status);
    }
}
