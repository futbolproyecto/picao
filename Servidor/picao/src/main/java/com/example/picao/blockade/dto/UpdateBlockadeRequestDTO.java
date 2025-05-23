package com.example.picao.blockade.dto;

import jakarta.validation.constraints.NotNull;

import java.util.Set;
import java.util.UUID;

public record UpdateBlockadeRequestDTO(

        @NotNull
        UUID id,

        Set<BlockadeRequestDTO> blockades
) {
}
