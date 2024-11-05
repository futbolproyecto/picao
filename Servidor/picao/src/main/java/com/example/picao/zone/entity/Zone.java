package com.example.picao.zone.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Entity
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "zones")
public class Zone {

    @Id
    Integer id;

    @Column(length = 30)
    String name;
}
