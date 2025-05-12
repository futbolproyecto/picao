package com.example.picao.agenda.service;

import com.example.picao.agenda.dto.AgendaResponseDTO;
import com.example.picao.agenda.dto.CreateAgendaRequestDTO;

import java.util.List;
import java.util.UUID;

public interface AgendaService {

    String create(List<CreateAgendaRequestDTO> createAgendaRequestDTO);

    List<AgendaResponseDTO> getByEstablishmentId(UUID establishmentId);
}
