package com.example.picao.player_profile.repository;

import com.example.picao.player_profile.entity.PlayerProfile;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface PlayerProfileRepository extends JpaRepository<PlayerProfile, Integer> {

    Optional<PlayerProfile> findByNickname(String nickname);

    Optional<PlayerProfile> findByUserId(Integer userId);


}
