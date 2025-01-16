package com.example.picao.team.entity;

import com.example.picao.city.entity.City;
import com.example.picao.department.entity.Department;
import com.example.picao.role.entity.Role;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.zone.entity.Zone;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.util.List;
import java.util.Set;

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

    @ManyToOne(fetch = FetchType.LAZY)
    UserEntity ownerUser;

    @ManyToMany(fetch = FetchType.LAZY, cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST,
            CascadeType.REFRESH})
    @JoinTable(name = "team_players",
            joinColumns = @JoinColumn(
                    name = "player_id"), inverseJoinColumns = @JoinColumn(name = "team_id"))
    Set<UserEntity> players;

    public Team(Integer id) {
        this.id = id;
    }
}