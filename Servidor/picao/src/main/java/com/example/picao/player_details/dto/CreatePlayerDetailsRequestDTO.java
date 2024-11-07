package com.example.picao.player_details.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;

public record CreatePlayerDetailsRequestDTO(
        @NotBlank
        @Length(max = 20)
        String nickname,
        @NotNull
        @Length(max = 5)
        Double stature,
        @NotNull
        @Length(max = 3)
        Integer weight,
        @NotNull
        @JsonProperty("position_player")
        Integer positionPlayer,
        @NotNull
        @JsonProperty("dominant_foot")
        Integer dominantFoot,
        @NotNull
        Integer zone,
        @NotNull
        Integer city,
        @NotNull
        Integer user) {


}
