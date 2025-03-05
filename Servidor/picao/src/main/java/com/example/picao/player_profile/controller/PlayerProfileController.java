package com.example.picao.player_profile.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.player_profile.dto.CreateUpdatePlayerProfileRequestDTO;
import com.example.picao.player_profile.service.PlayerProfileService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@RestController
@AllArgsConstructor
@RequestMapping("/player-profile")
public class PlayerProfileController {

    private final PlayerProfileService playerProfileService;

    @PostMapping(value = "create")
    public ResponseEntity<GenericResponseDTO> create(
            @RequestBody @Valid CreateUpdatePlayerProfileRequestDTO requestDTO) {
        return GenericResponseDTO.genericResponse(playerProfileService.createPlayerProfile(requestDTO));
    }

    @PutMapping(value = "update")
    public ResponseEntity<GenericResponseDTO> update(@RequestBody @Valid CreateUpdatePlayerProfileRequestDTO requestDTO) {
        return GenericResponseDTO.genericResponse(playerProfileService.update(requestDTO));
    }

}
