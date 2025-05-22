package com.example.picao.agenda.service.impl;

import com.example.picao.agenda.dto.AgendaResponseDTO;
import com.example.picao.agenda.entity.Agenda;
import com.example.picao.agenda.entity.TimeStatus;
import com.example.picao.agenda.mapper.AgendaMapper;
import com.example.picao.agenda.repository.AgendaRepository;
import com.example.picao.agenda.service.AgendaService;
import com.example.picao.blockade.entity.Blockade;
import com.example.picao.core.exception.AppException;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@RequiredArgsConstructor()
@Service
public class AgendaServiceImpl implements AgendaService {

    private static final AgendaMapper MAPPER = Mappers.getMapper(AgendaMapper.class);
    private final AgendaRepository agendaRepository;

    @Transactional
    @Override
    public void create(Blockade bloqueo) {

        try {

            List<Agenda> agendas = new ArrayList<>();

            LocalTime blockStart = bloqueo.getStartTime();
            LocalTime blockEnd = bloqueo.getEndTime();

            for (int hour = 0; hour <= 23; hour++) {
                LocalTime current = LocalTime.of(hour, 0);

                // Si está dentro del rango bloqueado, lo saltamos
                if (!current.isBefore(blockStart) && current.isBefore(blockEnd)) {
                    continue;
                }

                agendas.add(buildAgenda(bloqueo, current));
            }

            agendaRepository.saveAll(agendas);

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }


    }

    @Transactional(readOnly = true)
    @Override
    public List<AgendaResponseDTO> getByEstablishmentId(UUID establishmentId) {

        try {
            return agendaRepository.findByEstablishmentId(
                    establishmentId).stream().map(MAPPER::toAgendaResponseDTO).toList();
        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }

    }


    private Agenda buildAgenda(Blockade bloqueo, LocalTime time) {
        return Agenda.builder()
                .blockadeId(bloqueo.getRecordId())
                .date(bloqueo.getDate())
                .startTime(time)
                .status(TimeStatus.DISPONIBLE)
                .dayOfWeek(bloqueo.getDayOfWeek())
                .field(bloqueo.getField())
                .build();
    }
}
