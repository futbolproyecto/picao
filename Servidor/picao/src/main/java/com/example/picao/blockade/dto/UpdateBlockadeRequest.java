package com.example.picao.blockade.dto;

import jakarta.validation.constraints.NotNull;

import java.util.Set;
import java.util.UUID;

public record UpdateBlockadeRequest(

        @NotNull
        UUID id,

        Set<BlockadeRequestDTO> blockades
) {
}
