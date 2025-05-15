package com.example.picao.blockade.controller;

import com.example.picao.blockade.dto.BlockadeRequestDTO;
import com.example.picao.blockade.service.BlockadeService;
import com.example.picao.core.util.dto.GenericResponseDTO;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@AllArgsConstructor
@RequestMapping("/blockade")
public class BlockadeController {

    private final BlockadeService blockadeService;

    @PostMapping(value = "create")
    public ResponseEntity<GenericResponseDTO> create(
            @RequestBody @Valid List<BlockadeRequestDTO> requestDTO) {
        return GenericResponseDTO.genericResponse(blockadeService.create(requestDTO));
    }

    @GetMapping(value = "get-by-user-id/{userId}")
    public ResponseEntity<GenericResponseDTO> getByEstablishmentId(@PathVariable() Integer userId) {
        return GenericResponseDTO.genericResponse(blockadeService.getByUserId(userId));
    }
}
