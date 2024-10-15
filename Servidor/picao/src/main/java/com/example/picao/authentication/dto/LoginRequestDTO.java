package com.example.picao.authentication.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public record LoginRequestDTO(
        @JsonProperty("email_or_mobile_number")
        String emailOrMobileNumber,
        String password) {
}
