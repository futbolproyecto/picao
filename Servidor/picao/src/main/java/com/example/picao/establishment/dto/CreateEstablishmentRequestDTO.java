package com.example.picao.establishment.dto;

import com.example.picao.core.util.Constants;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;


public record CreateEstablishmentRequestDTO(

        @NotBlank
        @Size(max = 50, message = Constants.ERROR_MESSAGE_SIZE)
        String name,

        @NotBlank
        @Size(max = 100)
        String address,

        @NotBlank
        @Size(min = 10, message = Constants.ERROR_MESSAGE_PHONE_NUMBER_SIZE)
        @JsonProperty("mobile_number")
        String mobileNumber,

        @NotNull
        @JsonProperty("city_id")
        Integer cityId
) {
}
