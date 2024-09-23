package com.example.picao.core.util.dto;

import lombok.Data;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

@Data
public class GenericResponseDTO {
    private Integer status;
    private Object payload;

    public static ResponseEntity<GenericResponseDTO> genericResponse(Object payload) {

        GenericResponseDTO genericResponseDto = new GenericResponseDTO();
        genericResponseDto.setStatus(HttpStatus.OK.value());
        genericResponseDto.setPayload(payload);

        return new ResponseEntity<>(genericResponseDto, HttpStatus.OK);
    }
}
