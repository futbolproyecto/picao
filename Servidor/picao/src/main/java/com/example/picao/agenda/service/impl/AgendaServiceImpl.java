package com.example.picao.agenda.service.impl;

import com.example.picao.agenda.dto.CreateAgendaRequestDTO;
import com.example.picao.agenda.dto.LockDownDayDTO;
import com.example.picao.agenda.entity.Agenda;
import com.example.picao.agenda.entity.DayOfWeek;
import com.example.picao.agenda.entity.TimeStatus;
import com.example.picao.agenda.repository.AgendaRepository;
import com.example.picao.agenda.service.AgendaService;
import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.field.entity.Field;
import com.example.picao.field.repository.FieldRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.TextStyle;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@RequiredArgsConstructor()
@Service
public class AgendaServiceImpl implements AgendaService {

    private final AgendaRepository agendaRepository;
    private final FieldRepository fieldRepository;

    @Override
    public String create(List<CreateAgendaRequestDTO> createAgendaRequestDTO) {

        try {

            for (CreateAgendaRequestDTO request : createAgendaRequestDTO) {

                Field field = fieldRepository.findById(request.fieldId())
                        .orElseThrow(() -> new AppException(
                                ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Cancha"));

                // Crear un mapa: fecha → objeto de bloqueo
                Map<LocalDate, LockDownDayDTO> mapLockDate = request.lockDownDay().stream()
                        .collect(Collectors.toMap(LockDownDayDTO::day, Function.identity()));

                LocalDate currentDate = request.startDate();

                // si la fecha actual es menor a la final hace el ciclo
                while (!currentDate.isAfter(request.endDate())) {

                    //  Si ya hay registros para esa fecha y cancha, saltar
                    if (Boolean.TRUE.equals(agendaRepository.existsByFieldIdAndDate(field.getId(), currentDate))) {
                        currentDate = currentDate.plusDays(1);
                        continue;
                    }

                    LockDownDayDTO lockDownDayDTO = mapLockDate.get(currentDate);

                    DayOfWeek dayOfWeek = DayOfWeek.fromId(currentDate.getDayOfWeek().getValue());

                    if (lockDownDayDTO != null) {
                        for (int hour = 0; hour < 24; hour++) {
                            LocalTime currentHour = LocalTime.of(hour, 0);

                            // Guardar solo si está fuera del rango bloqueado
                            if (currentHour.isBefore(lockDownDayDTO.startTime()) ||
                                    !currentHour.isBefore(lockDownDayDTO.endTime())) {

                                Agenda agenda = new Agenda();
                                agenda.setDate(currentDate);
                                agenda.setStartTime(currentHour);
                                agenda.setEndTime(currentHour.plusHours(1));
                                agenda.setStatus(TimeStatus.DISPONIBLE);
                                agenda.setDayOfWeek(dayOfWeek);
                                agenda.setField(field);

                                agendaRepository.save(agenda);
                            }
                        }
                    }

                    currentDate = currentDate.plusDays(1);
                }
            }

            return "agendas creadas";

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }
    }
}
