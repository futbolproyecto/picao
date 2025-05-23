package com.example.picao.agenda.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;
import java.time.LocalTime;

public record LockDownDayDTO(

        @NotNull
        LocalDate day,

        @NotNull
        @JsonProperty("start_time")
        LocalTime startTime,

        @NotNull
        @JsonProperty("end_time")
        LocalTime endTime) {
}
