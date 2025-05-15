package com.example.picao.agenda.service.impl;

import com.example.picao.agenda.dto.AgendaResponseDTO;
import com.example.picao.agenda.dto.CreateAgendaRequestDTO;
import com.example.picao.agenda.dto.LockDownDayDTO;
import com.example.picao.agenda.entity.Agenda;
import com.example.picao.agenda.entity.DayOfWeek;
import com.example.picao.agenda.entity.TimeStatus;
import com.example.picao.agenda.mapper.AgendaMapper;
import com.example.picao.agenda.repository.AgendaRepository;
import com.example.picao.agenda.service.AgendaService;
import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.field.entity.Field;
import com.example.picao.field.repository.FieldRepository;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@RequiredArgsConstructor()
@Service
public class AgendaServiceImpl implements AgendaService {

    private static final AgendaMapper MAPPER = Mappers.getMapper(AgendaMapper.class);
    private final AgendaRepository agendaRepository;
    private final FieldRepository fieldRepository;

    @Transactional
    @Override
    public String create(List<CreateAgendaRequestDTO> createAgendaRequestDTO) {
        try {
            UUID agendaId = UUID.randomUUID();

            for (CreateAgendaRequestDTO request : createAgendaRequestDTO) {

                Field field = fieldRepository.findById(request.fieldId())
                        .orElseThrow(() -> new AppException(
                                ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Cancha"));

                for (LockDownDayDTO lockDownDayDTO : request.lockDownDay()) {
                    LocalDate date = lockDownDayDTO.day();

                    // Si ya hay registros para esa fecha y cancha, saltar
                    if (Boolean.TRUE.equals(agendaRepository.existsByFieldIdAndDate(field.getId(), date))) {
                        continue;
                    }

                    DayOfWeek dayOfWeek = DayOfWeek.fromId(date.getDayOfWeek().getValue());

                    for (int hour = 0; hour < 24; hour++) {
                        LocalTime currentHour = LocalTime.of(hour, 0);

                        // Determinar el estado: BLOQUEADO si está dentro del rango, DISPONIBLE si está fuera
                        TimeStatus status = (!currentHour.isBefore(lockDownDayDTO.startTime()) &&
                                currentHour.isBefore(lockDownDayDTO.endTime()))
                                ? TimeStatus.BLOQUEADO
                                : TimeStatus.DISPONIBLE;

                        Agenda agenda = new Agenda();
                        agenda.setRecordId(agendaId);
                        agenda.setDate(date);
                        agenda.setStartTime(currentHour);
                        agenda.setEndTime(currentHour.plusHours(1));
                        agenda.setStatus(status);
                        agenda.setDayOfWeek(dayOfWeek);
                        agenda.setField(field);

                        agendaRepository.save(agenda);
                    }
                }
            }

            return "agendas creadas";

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
}
