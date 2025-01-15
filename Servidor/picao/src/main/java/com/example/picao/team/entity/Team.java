package com.example.picao.team.entity;

import com.example.picao.city.entity.City;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.zone.entity.Zone;
import com.fasterxml.jackson.annotation.JsonIgnore;
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
@Table(name = "teams")
@NoArgsConstructor()

//TODO revisar JsonIgnore
public class Team {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(name = "name", length = 50)
    String name;

    @ManyToOne(fetch = FetchType.EAGER)
    @JsonIgnore
    City city;

    @ManyToOne(fetch = FetchType.EAGER)
    @JsonIgnore
    Zone zone;

    @ManyToOne(fetch = FetchType.EAGER)
    @JsonIgnore
    UserEntity user;

    public Team(Integer id) {
        this.id = id;
    }
}