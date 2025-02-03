package com.example.picao.team.repository;

import com.example.picao.team.dto.TeamResponseDTO;
import com.example.picao.team.entity.Team;
import jakarta.persistence.Tuple;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface TeamRepository extends JpaRepository<Team, Integer> {

    Optional<Team> findByName(String name);

    @Query(value = "SELECT new com.example.picao.team.dto.TeamResponseDTO(t.id, t.name) " +
            "FROM Team t " +
            "WHERE t.ownerUser.id = :userId " +
            "ORDER BY t.name ASC")
    Optional<List<TeamResponseDTO>> findByOwnerUserId(int userId);

    @Query(value = """
            SELECT t.id,
                   t.name ,
                   pos.name AS position_player,
                   (SELECT COUNT(*)
                    FROM team_players tp2
                    WHERE tp2.team_id = t.id) AS num_players
            FROM teams t
            JOIN team_players tp ON tp.team_id = t.id
            JOIN users u ON u.id = tp.player_id
            JOIN players_profile pp ON u.id = pp.user_id
            JOIN position_players pos ON pos.id = pp.position_player_id
            WHERE tp.player_id = :userId
            ORDER BY t.name
            """, nativeQuery = true)
    List<Tuple> findByUserId(int userId);

    @Query(value = "SELECT t.id AS team_id, t.name AS team_name, ps.name AS position, pp.nickname AS nickname " +
            "FROM teams t " +
            "JOIN team_players tp ON t.id = tp.team_id " +
            "JOIN users p ON tp.player_id = p.id " +
            "JOIN players_profile pp ON p.id = pp.user_id " +
            "JOIN position_players ps ON pp.position_player_id = ps.id " +
            "WHERE p.id = :userId ORDER BY t.name ASC",
            nativeQuery = true)
    List<Tuple> findTeamsByUserId(int userId);


}
