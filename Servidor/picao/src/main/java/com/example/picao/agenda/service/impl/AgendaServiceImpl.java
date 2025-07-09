package com.example.picao.agenda.service.impl;

import com.example.picao.agenda.dto.AgendaResponseDTO;
import com.example.picao.agenda.dto.CreateAgendaRequestDTO;
import com.example.picao.agenda.dto.InformationSchedule;
import com.example.picao.agenda.dto.ReserveRequestDTO;
import com.example.picao.agenda.entity.Agenda;
import com.example.picao.agenda.entity.DayOfWeek;
import com.example.picao.agenda.entity.TimeStatus;
import com.example.picao.agenda.mapper.AgendaMapper;
import com.example.picao.agenda.repository.AgendaRepository;
import com.example.picao.agenda.repository.AgendaSpecification;
import com.example.picao.agenda.service.AgendaService;
import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.core.util.UsefulMethods;
import com.example.picao.field.entity.Field;
import com.example.picao.field.repository.FieldRepository;
import com.example.picao.otp.service.OtpService;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;
import java.util.stream.Collectors;

@RequiredArgsConstructor()
@Service
public class AgendaServiceImpl implements AgendaService {

    private static final AgendaMapper MAPPER = Mappers.getMapper(AgendaMapper.class);
    private final AgendaRepository agendaRepository;
    private final FieldRepository fieldRepository;
    private final OtpService otpService;
    private final UserRepository userRepository;


    @Transactional
    @Override
    public String create(CreateAgendaRequestDTO request) {
        try {
            Set<LocalDate> recurringDates;

            if (request.rule() != null && !request.rule().isBlank()) {
                recurringDates = generateRecurringDates(request.startDate(), request.endDate(), request.rule());
            } else {
                recurringDates = Set.of(request.startDate());
            }

            for (UUID fieldId : request.fieldIds()) {

                Field field = fieldRepository.findById(fieldId)
                        .orElseThrow(() -> new AppException(
                                ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Cancha"));

                for (LocalDate date : recurringDates) {
                    for (InformationSchedule schedule : request.informationSchedules()) {

                        LocalTime currentTime = schedule.startTime();
                        while (currentTime.isBefore(schedule.endTime())) {
                            LocalTime nextTime = currentTime.plusHours(1);

                            Agenda agenda = Agenda.builder()
                                    .date(date)
                                    .startTime(currentTime)
                                    .endTime(nextTime)
                                    .status(TimeStatus.DISPONIBLE)
                                    .dayOfWeek(DayOfWeek.fromId(date.getDayOfWeek().getValue()))
                                    .fee(schedule.fee())
                                    .field(field)
                                    .build();


                            agendaRepository.save(agenda);

                            currentTime = nextTime;
                        }
                    }
                }
            }

            return "Agenda generada";

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

    @Override
    public List<AgendaResponseDTO> getAgendaAvailableByParameters(String cityName, LocalDate date,
                                                                  LocalTime startTime, LocalTime endTime,
                                                                  String establishmentName) {

        try {

            List<Agenda> agendas = agendaRepository.findAll(AgendaSpecification.filterBy(
                    cityName, date, startTime, endTime, establishmentName));

            if (agendas.isEmpty()) {
                throw new AppException(ErrorMessages.FIELD_NOT_FOUND, HttpStatus.NOT_FOUND);
            }

            return agendas.stream().map(agenda -> AgendaResponseDTO.builder()
                    .id(agenda.getId())
                    .nameField(agenda.getField().getName())
                    .nameEstablishment(agenda.getField().getEstablishment().getName())
                    .startTime(agenda.getStartTime())
                    .date(agenda.getDate())
                    .dayOfWeek(agenda.getDayOfWeek())
                    .addressEstablishment(agenda.getField().getEstablishment().getAddress())
                    .fee(agenda.getFee())
                    .build()).toList();

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }
    }

    @Transactional
    @Override
    public String reserve(ReserveRequestDTO requestDTO) {

        UserEntity user = userRepository.findByEmail(UsefulMethods.getLoggedUsername()).orElseThrow(
                () -> new AppException(ErrorMessages.USER_NOT_EXIST, HttpStatus.NOT_FOUND));
        try {

            if (Boolean.TRUE.equals(otpService.validateMobileNumber(requestDTO.otp(), user.getMobileNumber()))) {
                List<Agenda> agendas = requestDTO.agendaId().stream()
                        .map(uuid -> agendaRepository.findById(uuid)
                                .orElseThrow(() -> new AppException(
                                        ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Agenda")))
                        .toList();

                for (Agenda agenda : agendas) {
                    if (!TimeStatus.DISPONIBLE.equals(agenda.getStatus())) {
                        throw new AppException(ErrorMessages.AGENDA_NOT_AVAILABLE, HttpStatus.CONFLICT);
                    }
                    agenda.setStatus(TimeStatus.RESERVADO);
                    agenda.setUser(user);
                }

                agendaRepository.saveAll(agendas);
            }

            return "Reservas realizadas con éxito";

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }
    }

    @Override
    public Set<AgendaResponseDTO> getReserveByEstablishmentIdId(UUID establishmentId) {

        try {
            return agendaRepository.findByReserveByEstablishmentId(establishmentId);
        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }
    }

    /**
     * genera las fechas en las cuales se deben hacer la creacion de agendas
     **/

    private Set<LocalDate> generateRecurringDates(LocalDate startDate, LocalDate endDate, String rule) {
        Set<LocalDate> date = new HashSet<>();

        // Extraer los días de la semana desde la regla
        String[] parts = rule.split("BYDAY=");
        if (parts.length < 2) return date;

        String[] dias = parts[1].split(",");
        Set<java.time.DayOfWeek> diasPermitidos = Arrays.stream(dias)
                .map(this::mapDay)
                .collect(Collectors.toSet());

        LocalDate current = startDate;
        while (!current.isAfter(endDate)) {
            if (diasPermitidos.contains(current.getDayOfWeek())) {
                date.add(current);
            }
            current = current.plusDays(1);
        }

        return date;
    }


    private java.time.DayOfWeek mapDay(String dia) {
        return switch (dia.trim()) {
            case "MO" -> java.time.DayOfWeek.MONDAY;
            case "TU" -> java.time.DayOfWeek.TUESDAY;
            case "WE" -> java.time.DayOfWeek.WEDNESDAY;
            case "TH" -> java.time.DayOfWeek.THURSDAY;
            case "FR" -> java.time.DayOfWeek.FRIDAY;
            case "SA" -> java.time.DayOfWeek.SATURDAY;
            case "SU" -> java.time.DayOfWeek.SUNDAY;
            default -> throw new IllegalArgumentException("Día inválido en RRULE: " + dia);
        };
    }

}
