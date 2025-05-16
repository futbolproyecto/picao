package com.example.picao.blockade.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Set;
import java.util.UUID;

public record BlockadeRequestDTO(


        @NotNull
        @JsonProperty("field_id")
        UUID fieldId,

        @NotNull
        @JsonProperty("start_time")
        LocalTime startTime,

        @NotNull
        @JsonProperty("end_time")
        LocalTime endTime,

        Set<LocalDate> days
) {
}
