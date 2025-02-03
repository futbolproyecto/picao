package com.example.picao.team.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.team.dto.CreateTeamRequestDTO;
import com.example.picao.team.dto.UserTeamAddRequestDTO;
import com.example.picao.team.service.TeamService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


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

    @GetMapping(value = "get-by-owner-user-id/{userId}")
    public ResponseEntity<GenericResponseDTO> getByOwnerUserId(@PathVariable int userId) {
        return GenericResponseDTO.genericResponse(teamService.getByOwnerUserId(userId));
    }

    @PostMapping(value = "add-user-team")
    public ResponseEntity<GenericResponseDTO> addUserToTeam(@RequestBody @Valid UserTeamAddRequestDTO userTeamAddRequestDTO) {
        return GenericResponseDTO.genericResponse(teamService.addUserToTeam(userTeamAddRequestDTO));
    }

    @GetMapping(value = "get-by-user-id/{userId}")
    public ResponseEntity<GenericResponseDTO> getByUserId(@PathVariable int userId) {
        return GenericResponseDTO.genericResponse(teamService.getByUserId(userId));
    }

    @GetMapping(value = "get-teams-by-user-id/{userId}")
    public ResponseEntity<GenericResponseDTO> getTeamsByUserId(@PathVariable int userId) {
        return GenericResponseDTO.genericResponse(teamService.getTeamsByUserId(userId));
    }

}
