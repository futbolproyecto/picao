package com.example.picao.player_profile.entity;

import com.example.picao.city.entity.City;
import com.example.picao.dominant_foot.entity.DominantFoot;
import com.example.picao.position_player.entity.PositionPlayer;
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
@Table(name = "player_profile")
public class PlayerProfile {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(length = 20, unique = true)
    String nickname;

    @Column(length = 5)
    Double stature;

    @Column(length = 3)
    Integer weight;

    @ManyToOne(fetch = FetchType.LAZY)
    PositionPlayer positionPlayer;

    @ManyToOne(fetch = FetchType.LAZY)
    DominantFoot dominantFoot;

    @ManyToOne(fetch = FetchType.LAZY)
    Zone zone;

    @ManyToOne(fetch = FetchType.LAZY)
    City city;

    @OneToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id", unique = true)
    UserEntity user;


}
