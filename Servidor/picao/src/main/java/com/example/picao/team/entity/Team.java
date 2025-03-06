package com.example.picao.team.entity;

import com.example.picao.city.entity.City;
import com.example.picao.user.entity.UserEntity;
import com.example.picao.zone.entity.Zone;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.util.Set;

@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor()
@Getter
@Setter
@Table(name = "teams")
@Entity
public class Team {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(name = "name", length = 50)
    String name;

    @ManyToOne(fetch = FetchType.EAGER)
    City city;

    @ManyToOne(fetch = FetchType.EAGER)
    Zone zone;

    @ManyToOne(fetch = FetchType.LAZY)
    UserEntity ownerUser;

    @ManyToMany(fetch = FetchType.LAZY, cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST, CascadeType.REFRESH})
    @JoinTable(name = "team_players",
            joinColumns = @JoinColumn(name = "team_id"),
            inverseJoinColumns = @JoinColumn(name = "player_id"))
    Set<UserEntity> players;

}