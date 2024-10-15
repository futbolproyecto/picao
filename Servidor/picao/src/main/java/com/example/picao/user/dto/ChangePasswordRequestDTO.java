package com.example.picao.user.dto;

import com.example.picao.core.util.Constants;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;

public record ChangePasswordRequestDTO(

        @Email(regexp = Constants.REGEX_EMAIL, message = Constants.ERROR_MESSAGE_EMAIL)
        String email,
        @Pattern(regexp = Constants.PASSWORD_PATTERN, message = Constants.ERROR_MESSAGE_PASSWORD)
        String password,
        String otp
) {
}
