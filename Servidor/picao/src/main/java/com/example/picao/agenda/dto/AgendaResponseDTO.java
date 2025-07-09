package com.example.picao.agenda.dto;

import com.example.picao.agenda.entity.DayOfWeek;
import com.example.picao.agenda.entity.TimeStatus;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
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

    TimeStatus status;

    @JsonProperty("day_of_week")
    DayOfWeek dayOfWeek;

    @JsonProperty("name_field")
    String nameField;

    @JsonProperty("field_id")
    UUID fieldId;

    @JsonProperty("name_establishment")
    String nameEstablishment;

    @JsonProperty("address_establishment")
    String addressEstablishment;

    BigDecimal fee;

    @JsonProperty("user_id")
    Integer userId;

    @JsonProperty("user_name")
    String userName;

    @JsonProperty("user_last_name")
    String userLastName;

    @JsonProperty("mobile_number")
    String mobileNumber;


    public AgendaResponseDTO(UUID id, LocalDate date, LocalTime startTime, TimeStatus status, DayOfWeek dayOfWeek,
                             String nameField, UUID fieldId, Integer userId, String userName, String userLastName,
                             String mobileNumber) {
        this.id = id;
        this.date = date;
        this.startTime = startTime;
        this.status = status;
        this.dayOfWeek = dayOfWeek;
        this.nameField = nameField;
        this.fieldId = fieldId;
        this.userName = userName;
        this.userLastName = userLastName;
        this.mobileNumber = mobileNumber;
        this.userId = userId;
    }
}
