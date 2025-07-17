package com.example.picao.agenda.dto;

import com.example.picao.agenda.entity.AgendaStatus;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;

import java.util.UUID;

public record ChangeReservationStatusRequestDTO(

        @NotBlank
        @JsonProperty("agenda_id")
        UUID agendaId,

        @NotBlank
        @JsonProperty("agenda_status")
        AgendaStatus status
) {


}
