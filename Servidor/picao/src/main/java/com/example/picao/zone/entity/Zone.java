package com.example.picao.zone.entity;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Entity
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "zones")
@NoArgsConstructor
public class Zone {
    public Zone(Integer id) {
        this.id = id;
    }

    @Id
    Integer id;

    @Column(length = 30)
    String name;
}
