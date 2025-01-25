package com.example.picao.team.repository;

import com.example.picao.team.dto.TeamResponseDTO;
import com.example.picao.team.entity.Team;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import javax.swing.text.html.Option;
import java.util.List;
import java.util.Optional;

public interface TeamRepository extends JpaRepository<Team, Integer> {

    Optional<Team> findByName(String name);

    @Query(value = "SELECT new com.example.picao.team.dto.TeamResponseDTO(t.id, t.name) " +
            "FROM Team t WHERE t.ownerUser.id = :userId")
    Optional<List<TeamResponseDTO>> findByOwnerUserId(int userId);
}
