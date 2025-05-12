package com.example.picao.agenda.dto;

import com.example.picao.agenda.entity.DayOfWeek;
import com.example.picao.agenda.entity.TimeStatus;
import com.example.picao.field.dto.FieldResponseDTO;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AgendaResponseDTO {

    UUID id;

    LocalDate date;

    @JsonProperty("start_time")
    LocalTime startTime;

    @JsonProperty("endt_time")
    LocalTime endTime;

    TimeStatus status;

    @JsonProperty("day_of_week")
    DayOfWeek dayOfWeek;

}
