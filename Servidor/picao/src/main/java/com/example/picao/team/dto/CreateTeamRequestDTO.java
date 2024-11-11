package com.example.picao.team.dto;

import com.example.picao.core.util.Constants;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record CreateTeamRequestDTO(
        @Size(max = 50, message = Constants.ERROR_MESSAGE_SIZE_NAME_TEAM)
        String name,

        @NotNull
        @JsonProperty("zone_id")
        Integer zoneId,

        @NotNull
        @JsonProperty("city_id")
        Integer cityId,

        @NotNull
        @JsonProperty("user_id")
        Integer userId) {
}
