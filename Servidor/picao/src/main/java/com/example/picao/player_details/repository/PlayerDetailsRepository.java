package com.example.picao.player_details.repository;

import com.example.picao.player_details.entity.PlayerDetails;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PlayerDetailsRepository extends JpaRepository<PlayerDetails, Integer> {
}
