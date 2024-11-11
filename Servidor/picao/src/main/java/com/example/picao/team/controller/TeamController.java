package com.example.picao.team.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.team.dto.CreateTeamRequestDTO;
import com.example.picao.team.service.TeamService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
@AllArgsConstructor
@RequestMapping("/team")
public class TeamController {

    private final TeamService teamService;

    @PostMapping(value = "create")
    public ResponseEntity<GenericResponseDTO> create(
            @RequestBody @Valid CreateTeamRequestDTO requestDTO) {
        return GenericResponseDTO.genericResponse(teamService.createTeam(requestDTO));
    }

}
