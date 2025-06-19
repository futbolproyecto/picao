package com.example.picao.agenda.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;

import java.math.BigDecimal;
import java.time.LocalTime;

public record InformationSchedule(

        @NotNull
        BigDecimal fee,

        @NotNull
        @JsonProperty("start_time")
        LocalTime startTime,

        @NotNull
        @JsonProperty("end_time")
        LocalTime endTime) {
}
