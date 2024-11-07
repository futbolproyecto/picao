package com.example.picao.player_profile.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.player_profile.dto.CreatePlayerProfileRequestDTO;
import com.example.picao.player_profile.service.PlayerProfileService;
import com.example.picao.user.dto.ChangePasswordRequestDTO;
import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.service.UserService;
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
            @RequestBody @Valid CreatePlayerProfileRequestDTO requestDTO) {
        return GenericResponseDTO.genericResponse(playerProfileService.createPlayerProfile(requestDTO));
    }

}
