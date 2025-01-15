package com.example.picao.team.dto;

import com.example.picao.core.util.Constants;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Size;

public record TeamResponseDTO(
        @Size(max = 50, message = Constants.ERROR_MESSAGE_SIZE_NAME_TEAM)
        String name,
        @JsonProperty("user_id")
        Integer userId) {
}
