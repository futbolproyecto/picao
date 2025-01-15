package com.example.picao.team.repository;

import com.example.picao.team.entity.Team;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface TeamRepository extends JpaRepository<Team, Integer> {

    Optional<Team> findByName(String name);

    Optional<List<Team>> findTeamByUserId(int userId);
}
