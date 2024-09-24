package com.example.picao.authentication.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public record LoginRequestDTO(
        @JsonProperty("mobile_number")
        String mobile_number,
        String password) {
}
