package com.example.picao.agenda.entity;

import com.example.picao.field.entity.Field;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor()
@Getter
@Setter
@Table(name = "agendas")
@Entity
public class Agenda {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    private LocalDate date;

    private LocalTime startTime;

    private LocalTime endTime;

    @Column(length = 30)
    @Enumerated(EnumType.STRING)
    private TimeStatus status;

    @Column(name = "day_of_week",length = 10)
    @Enumerated(EnumType.STRING)
    private DayOfWeek dayOfWeek;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "field_id")
    private Field field;
}
