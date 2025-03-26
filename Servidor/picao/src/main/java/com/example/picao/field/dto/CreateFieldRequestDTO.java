package com.example.picao.field.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

import java.util.UUID;

public record CreateFieldRequestDTO(

        @NotBlank
        @Size(max = 200)
        String name,

        @NotNull
        @Max(30)
        Integer capacity,

        @NotNull
        @JsonProperty("is_available")
        Boolean isAvailable,

        @NotNull
        @JsonProperty("is_roofed")
        Boolean isRoofed,

        @NotNull
        @JsonProperty("establishment_id")
        UUID establishmentId


) {
}
