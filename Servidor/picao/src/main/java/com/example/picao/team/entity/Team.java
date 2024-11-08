package com.example.picao.team.entity;

import com.example.picao.city.entity.City;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.zone.entity.Zone;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Entity
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "teams")
public class Team {
    @Id
    @Column(name = "id", nullable = false)
    Integer id;

    @Column(name = "name", length = 50)
    String name;

    @ManyToOne(fetch = FetchType.LAZY)
    City city;

    @ManyToOne(fetch = FetchType.LAZY)
    Zone zone;

    @ManyToOne(fetch = FetchType.LAZY)
    UserEntity user;


}