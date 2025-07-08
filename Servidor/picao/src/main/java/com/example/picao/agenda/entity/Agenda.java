package com.example.picao.agenda.entity;

import com.example.picao.field.entity.Field;
import com.example.picao.user.entity.UserEntity;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor()
@AllArgsConstructor
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

    @Column(name = "day_of_week", length = 10)
    @Enumerated(EnumType.STRING)
    private DayOfWeek dayOfWeek;

    @Column(precision = 15, scale = 2)
    private BigDecimal fee;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "field_id")
    private Field field;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private UserEntity user;

}
