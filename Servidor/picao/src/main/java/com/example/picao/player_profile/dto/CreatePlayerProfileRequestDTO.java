package com.example.picao.player_profile.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.*;

public record CreatePlayerProfileRequestDTO(
        @NotBlank
        @Size(max = 20)
        String nickname,
        @NotNull
        @Max(5)
        Double stature,
        @NotNull
        Integer weight,
        @NotNull
        @JsonProperty("position_player_id")
        Integer positionPlayerId,
        @NotNull
        @JsonProperty("dominant_foot_id")
        Integer dominantFootId,
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
