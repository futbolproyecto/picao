package com.example.picao.team.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.*;

public record UserTeamAddDTO(
        @NotNull
        @JsonProperty("team_id")
        Integer teamId,

        @NotNull
        @JsonProperty("user_id")
        Integer userId) {
}
