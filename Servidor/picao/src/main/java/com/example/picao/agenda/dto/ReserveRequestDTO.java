package com.example.picao.agenda.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotBlank;

import java.util.Set;
import java.util.UUID;

public record ReserveRequestDTO(

        @JsonProperty("agenda_id")
        Set<UUID> agendaId,

        @NotBlank
        String otp

) {
}
