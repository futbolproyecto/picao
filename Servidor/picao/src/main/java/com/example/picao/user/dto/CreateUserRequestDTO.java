package com.example.picao.user.dto;

import com.example.picao.core.util.Constants;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.time.LocalDate;

public record CreateUserRequestDTO(
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
        @Size(min = 10, message = Constants.VALIDATE_PHONE_NUMBER)
        @JsonProperty("mobile_number")
        String mobileNumber,
        @Email(regexp = Constants.REGEX_EMAIL, message = "Ingresa un correo electrónico válido.")
        String email,
        @NotBlank
        @Size(min = 6, message = Constants.VALIDATE_PASSWORD)
        String password,
        @JsonFormat(pattern = "yyyy-MM-dd")
        @JsonProperty("date_of_birth")
        LocalDate dateOfBirth
) {

}
