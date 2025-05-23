package com.example.picao.blockade.entity;

import com.example.picao.agenda.entity.DayOfWeek;
import com.example.picao.field.entity.Field;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;

@Builder
@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor()
@AllArgsConstructor
@Getter
@Setter
@Table(name = "blockades")
@Entity
public class Blockade {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    UUID recordId;

    LocalDate date;

    LocalTime startTime;

    LocalTime endTime;

    @Column(name = "day_of_week", length = 10)
    @Enumerated(EnumType.STRING)
    private DayOfWeek dayOfWeek;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "field_id")
    private Field field;


}
