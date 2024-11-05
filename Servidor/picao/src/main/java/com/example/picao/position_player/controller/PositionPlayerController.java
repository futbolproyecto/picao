package com.example.picao.position_player.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.position_player.service.PositionPlayerService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/position-player")
public class PositionPlayerController {
    private final PositionPlayerService positionPlayerService;

    @GetMapping(value = "get-all")
    public ResponseEntity<GenericResponseDTO> getAll() {
        return GenericResponseDTO.genericResponse(positionPlayerService.getPositionPlayers());
    }

}
