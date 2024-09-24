package com.example.picao.user.dto;

import com.example.picao.core.util.Constants;
import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

import java.time.LocalDate;

/**
 * Clase DTO para transferencia de datos relacionados a usuario
 */

public record CreateUserRequestDTO(
        @NotBlank
        String name,
        String secondName,
        @NotBlank
        String lastName,
        String secondLastName,
        @NotBlank
        @Size(min = 10, message = Constants.VALIDATE_PHONE_NUMBER)
        String mobileNumber,
        @Email(regexp = Constants.REGEX_EMAIL, message = "Correo invalido")
        String email,
        @NotBlank
        @Size(min = 6, message = Constants.VALIDATE_PHONE_NUMBER)
        String password,
        @JsonFormat(pattern = "yyyy-MM-dd")
        LocalDate dateOfBirth
) {

}
