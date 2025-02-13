package com.example.picao.position_player.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Entity
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "position_players")
@NoArgsConstructor()
public class PositionPlayer {
    @Id
    Integer id;

    @Column(length = 30)
    String name;

    public PositionPlayer(Integer id) {
        this.id = id;
    }
}
