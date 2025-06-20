package com.example.picao.agenda.service;

import com.example.picao.agenda.dto.AgendaResponseDTO;
import com.example.picao.agenda.dto.CreateAgendaRequestDTO;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

public interface AgendaService {

    String create(CreateAgendaRequestDTO request);

    List<AgendaResponseDTO> getByEstablishmentId(UUID establishmentId);

    List<AgendaResponseDTO> getAgendaAvailableByParameters(String cityName, LocalDate date, LocalTime startTime,
                                                           LocalTime endTime, String establishmentName);
}
