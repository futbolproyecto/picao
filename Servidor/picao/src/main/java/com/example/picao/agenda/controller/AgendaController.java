package com.example.picao.agenda.controller;

import com.example.picao.agenda.dto.CreateAgendaRequestDTO;
import com.example.picao.agenda.service.AgendaService;
import com.example.picao.core.util.dto.GenericResponseDTO;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

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
}
