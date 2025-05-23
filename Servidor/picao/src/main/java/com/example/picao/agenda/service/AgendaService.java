package com.example.picao.agenda.service;

import com.example.picao.agenda.dto.AgendaResponseDTO;
import com.example.picao.blockade.entity.Blockade;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

public interface AgendaService {

    void create(Blockade bloqueo);

    List<AgendaResponseDTO> getByEstablishmentId(UUID establishmentId);

    List<AgendaResponseDTO> getAgendaAvailableByParameters(String cityName, LocalDate date, LocalTime hour,
                                                           String establishmentName);
}
