package com.example.picao.team.service;

import com.example.picao.team.dto.CreateTeamRequestDTO;
import com.example.picao.team.dto.TeamResponseDTO;
import com.example.picao.team.dto.UserTeamAddRequestDTO;

import java.util.List;

public interface TeamService {

    TeamResponseDTO createTeam(CreateTeamRequestDTO requestDTO);

    List<TeamResponseDTO> getByOwnerUserId(int userId);

    TeamResponseDTO addUserToTeam(UserTeamAddRequestDTO userTeamAddRequestDTO);

    List<TeamResponseDTO> getTeamsByUserId(int userId);

    TeamResponseDTO getTeamByUserId(int userId, int teamId);

    String leaveTheTeam(int userdId, int teamId);

}
