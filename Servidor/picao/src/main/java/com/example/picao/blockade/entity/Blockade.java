package com.example.picao.blockade.entity;

import com.example.picao.agenda.entity.DayOfWeek;
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
@Table(name = "blockades", uniqueConstraints = @UniqueConstraint(columnNames = {
        "field_id", "date", "start_time", "end_time"
}))
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
