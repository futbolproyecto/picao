package com.example.picao.field.dto;

import com.example.picao.agenda.dto.AgendaResponseDTO;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
public class FieldResponseDTO {

    UUID id;

    String name;

    Integer capacity;

    @JsonProperty("is_available")
    Boolean isAvailable;

    @JsonProperty("is_roofed")
    Boolean isRoofed;

    List<AgendaResponseDTO> agendas;

    public FieldResponseDTO(UUID id, String name, Integer capacity, Boolean isAvailable, Boolean isRoofed) {
        this.id = id;
        this.name = name;
        this.capacity = capacity;
        this.isAvailable = isAvailable;
        this.isRoofed = isRoofed;
    }
}
