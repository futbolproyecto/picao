package com.example.picao.position_player.repository;

import com.example.picao.position_player.entity.PositionPlayer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PositionPlayerRepository extends JpaRepository<PositionPlayer, Integer> {
}
