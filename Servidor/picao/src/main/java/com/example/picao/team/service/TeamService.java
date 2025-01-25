package com.example.picao.team.service;

import com.example.picao.team.dto.CreateTeamRequestDTO;
import com.example.picao.team.dto.TeamResponseDTO;
import com.example.picao.team.dto.UserTeamAddDTO;
import com.example.picao.team.entity.Team;
import com.example.picao.team.entity.UsersByTeam;

import java.util.List;

public interface TeamService {

    Team createTeam(CreateTeamRequestDTO requestDTO);

    List<TeamResponseDTO> getByUserId(int userId);

    UsersByTeam addUserToTeam(UserTeamAddDTO userTeamAddDTO);

}
