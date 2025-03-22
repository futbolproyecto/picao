package com.example.picao;

import com.example.picao.field.entity.Field;
import com.example.picao.user.entity.UserEntity;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalTime;

@Getter
@Setter
@Entity
@Table(name = "fields_schedules")
public class FieldsSchedule {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "field_id")
    private Field field;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private UserEntity userEntity;

    @Column(name = "start_time")
    private LocalTime startTime;

    @Column(name = "number_hours")
    private Integer numberHours;

    @Column(name = "state_id")
    private Integer stateId;

}