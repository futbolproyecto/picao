package com.example.picao.agenda.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

public record CreateAgendaRequestDTO(

        @NotNull
        @JsonProperty("start_date")
        LocalDate startDate,

        @NotNull
        @JsonProperty("end_date")
        LocalDate endDate,

        @NotNull
        @JsonProperty("lock_down_day")
        List<LockDownDayDTO> lockDownDay,

        @NotNull
        @JsonProperty("field_id")
        UUID fieldId
) {
}
