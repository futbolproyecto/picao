package com.example.picao.user.dto;

import com.example.picao.core.util.Constants;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.*;

import java.time.LocalDate;

public record UpdateUserRequestDTO(
        @NotNull
        Integer id,
        @NotBlank
        String name,
        @JsonProperty("second_name")
        String secondName,
        @NotBlank
        @JsonProperty("last_name")
        String lastName,
        @JsonProperty("second_last_name")
        String secondLastName,
        @NotBlank
        @Size(min = 10, message = Constants.ERROR_MESSAGE_PHONE_NUMBER_SIZE)
        @JsonProperty("mobile_number")
        String mobileNumber,
        @Email(regexp = Constants.REGEX_EMAIL, message = Constants.ERROR_MESSAGE_EMAIL)
        String email,
        @JsonFormat(pattern = "yyyy-MM-dd")
        @JsonProperty("date_of_birth")
        LocalDate dateOfBirth
) {
}
