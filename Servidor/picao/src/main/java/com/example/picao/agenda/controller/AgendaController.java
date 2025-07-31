package com.example.picao.agenda.controller;

import com.example.picao.agenda.dto.ChangeReservationStatusRequestDTO;
import com.example.picao.agenda.dto.CreateAgendaRequestDTO;
import com.example.picao.agenda.dto.ReserveRequestDTO;
import com.example.picao.agenda.service.AgendaService;
import com.example.picao.core.util.dto.GenericResponseDTO;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

@RestController
@AllArgsConstructor
@RequestMapping("/agenda")
public class AgendaController {

    private final AgendaService agendaService;

    @PostMapping(value = "create")
    public ResponseEntity<GenericResponseDTO> create(@RequestBody CreateAgendaRequestDTO request) {
        return GenericResponseDTO.genericResponse(agendaService.create(request));
    }

    @GetMapping(value = "get-by-establishment-id/{establishmentId}")
    public ResponseEntity<GenericResponseDTO> getByEstablishmentId(@PathVariable() UUID establishmentId) {
        return GenericResponseDTO.genericResponse(agendaService.getByEstablishmentId(establishmentId));
    }

    @GetMapping("/get-available-by-filters")
    public ResponseEntity<GenericResponseDTO> getAgendaAvailableByParameters(
            @RequestParam(name = "city-name") String cityName,
            @RequestParam(required = false) LocalDate date,
            @RequestParam(name = "start-time", required = false) LocalTime startTime,
            @RequestParam(name = "end-time", required = false) LocalTime endTime,
            @RequestParam(name = "establishment-name", required = false) String establishmentName) {

        return GenericResponseDTO.genericResponse(
                agendaService.getAgendaAvailableByParameters(cityName, date, startTime, endTime, establishmentName));
    }

    @PostMapping("/reserve")
    public ResponseEntity<GenericResponseDTO> reserve(
            @RequestBody ReserveRequestDTO request) {
        return GenericResponseDTO.genericResponse(agendaService.reserve(request));
    }

    @GetMapping(value = "get-reserve-by-establishment-id/{establishmentId}")
    public ResponseEntity<GenericResponseDTO> getReserveByEstablishmentId(@PathVariable() UUID establishmentId) {
        return GenericResponseDTO.genericResponse(agendaService.getReserveByEstablishmentIdId(establishmentId));
    }

    @PutMapping(value = "change-reservation-status")
    public ResponseEntity<GenericResponseDTO> getReserveByEstablishmentId(
            @RequestBody() ChangeReservationStatusRequestDTO requestDTO) {
        return GenericResponseDTO.genericResponse(agendaService.changeReservationStatus(requestDTO));
    }

    @GetMapping("get-agenda-status")
    public ResponseEntity<GenericResponseDTO> getAgendaStatus() {
        return GenericResponseDTO.genericResponse(agendaService.getAgendaStatus());
    }

}
