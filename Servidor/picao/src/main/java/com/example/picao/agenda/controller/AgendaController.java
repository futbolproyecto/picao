package com.example.picao.agenda.controller;

import com.example.picao.agenda.dto.CreateAgendaRequestDTO;
import com.example.picao.agenda.service.AgendaService;
import com.example.picao.core.util.dto.GenericResponseDTO;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@AllArgsConstructor
@RequestMapping("/agenda")
public class AgendaController {

    private final AgendaService agendaService;

    @PostMapping(value = "create")
    public ResponseEntity<GenericResponseDTO> create(
            @RequestBody @Valid List<CreateAgendaRequestDTO> requestDTO) {
        return GenericResponseDTO.genericResponse(agendaService.create(requestDTO));
    }

    @GetMapping(value = "get-by-establishment-id/{establishmentId}")
    public ResponseEntity<GenericResponseDTO> getByEstablishmentId(@PathVariable() UUID establishmentId) {
        return GenericResponseDTO.genericResponse(agendaService.getByEstablishmentId(establishmentId));
    }
}
