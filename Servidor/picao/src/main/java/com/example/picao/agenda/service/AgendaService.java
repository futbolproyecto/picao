package com.example.picao.agenda.service;

import com.example.picao.agenda.dto.AgendaResponseDTO;
import com.example.picao.agenda.dto.ChangeReservationStatusRequestDTO;
import com.example.picao.agenda.dto.CreateAgendaRequestDTO;
import com.example.picao.agenda.dto.ReserveRequestDTO;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Set;
import java.util.UUID;

public interface AgendaService {

    String create(CreateAgendaRequestDTO request);

    List<AgendaResponseDTO> getByEstablishmentId(UUID establishmentId);

    List<AgendaResponseDTO> getAgendaAvailableByParameters(String cityName, LocalDate date, LocalTime startTime,
                                                           LocalTime endTime, String establishmentName);

    Set<AgendaResponseDTO> reserve(ReserveRequestDTO requestDTO);

    Set<AgendaResponseDTO> getReserveByEstablishmentIdId(UUID establishmentIdId);

    AgendaResponseDTO changeReservationStatus(ChangeReservationStatusRequestDTO requestDTO);
}
