package com.example.picao.blockade.dto.projection;

import com.example.picao.agenda.entity.DayOfWeek;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

public interface BlockeadeProjection {
    UUID getEstablishmentId();

    String getEstablishmentName();

    UUID getFieldId();

    String getFieldName();

    UUID getAgendaId();

    LocalDate getDate();

    LocalTime getStartTime();

    LocalTime getEndTime();

    DayOfWeek getDayOfWeek();

    UUID getRecordId();
}
