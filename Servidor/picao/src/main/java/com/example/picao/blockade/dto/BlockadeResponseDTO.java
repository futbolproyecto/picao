package com.example.picao.blockade.dto;

import com.example.picao.agenda.entity.DayOfWeek;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@JsonInclude(JsonInclude.Include.NON_NULL)
@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
public class BlockadeResponseDTO {

    UUID id;

    @JsonProperty("start_time")
    LocalTime startTime;

    @JsonProperty("end_time")
    LocalTime endTime;

    @JsonProperty("start_date")
    LocalDate startDate;

    @JsonProperty("end_date")
    LocalDate endDate;

    @JsonProperty("days_of_week")
    List<DayOfWeek> daysOfWeek;
}
