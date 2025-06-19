package com.example.picao.agenda.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;
import java.util.Set;
import java.util.UUID;

public record CreateAgendaRequestDTO(

        @NotNull
        @JsonProperty("field_ids")
        Set<UUID> fieldIds,

        @NotNull
        @JsonProperty("start_date")
        LocalDate startDate,

        @NotNull
        @JsonProperty("end_date")
        LocalDate endDate,

        String rule,

        @NotNull
        @JsonProperty("information_schedules")
        Set<InformationSchedule> informationSchedules


) {
}
