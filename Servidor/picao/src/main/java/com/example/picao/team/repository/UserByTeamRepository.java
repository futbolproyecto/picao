package com.example.picao.team.repository;

import com.example.picao.team.entity.UsersByTeam;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserByTeamRepository extends JpaRepository<UsersByTeam, Integer> {
}
