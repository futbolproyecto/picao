package com.example.picao.team.service;

import com.example.picao.team.dto.CreateTeamRequestDTO;
import com.example.picao.team.entity.Team;

public interface TeamService {

    Team createTeam(CreateTeamRequestDTO requestDTO);
}
