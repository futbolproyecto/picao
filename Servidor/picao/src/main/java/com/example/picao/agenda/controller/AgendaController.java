package com.example.picao.agenda.controller;

import com.example.picao.agenda.service.AgendaService;
import com.example.picao.core.util.dto.GenericResponseDTO;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@AllArgsConstructor
@RequestMapping("/agenda")
public class AgendaController {

    private final AgendaService agendaService;

    @GetMapping(value = "get-by-establishment-id/{establishmentId}")
    public ResponseEntity<GenericResponseDTO> getByEstablishmentId(@PathVariable() UUID establishmentId) {
        return GenericResponseDTO.genericResponse(agendaService.getByEstablishmentId(establishmentId));
    }
}
