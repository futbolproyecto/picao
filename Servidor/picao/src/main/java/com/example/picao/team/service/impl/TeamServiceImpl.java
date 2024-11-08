package com.example.picao.team.service.impl;


import com.example.picao.team.dto.CreateTeamRequestDTO;
import com.example.picao.team.service.TeamService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@RequiredArgsConstructor()
@Service
public class TeamServiceImpl implements TeamService {

    @Override
    public int createTeam(CreateTeamRequestDTO requestDTO) {
        return 0;
    }
}



