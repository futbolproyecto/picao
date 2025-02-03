package com.example.picao.team.service;

import com.example.picao.team.dto.CreateTeamRequestDTO;
import com.example.picao.team.dto.TeamResponseDTO;
import com.example.picao.team.dto.UserTeamAddRequestDTO;
import com.example.picao.team.entity.Team;

import java.util.List;

public interface TeamService {

    Team createTeam(CreateTeamRequestDTO requestDTO);

    List<TeamResponseDTO> getByOwnerUserId(int userId);

    TeamResponseDTO addUserToTeam(UserTeamAddRequestDTO userTeamAddRequestDTO);

    List<TeamResponseDTO> getByUserId(int userId);

    List<TeamResponseDTO> getTeamsByUserId(int userId);

}
