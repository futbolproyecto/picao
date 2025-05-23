package com.example.picao.agenda.dto.projection;

import com.example.picao.agenda.entity.DayOfWeek;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

public interface AgendaAvailableProjection {

    UUID getAgendaId();

    LocalDate getDate();

    LocalTime getStartTime();

    String getFieldName();

    String getEstablishmentName();

    DayOfWeek getDayOfWeek();

    String getEstablishmentAddress();
}
