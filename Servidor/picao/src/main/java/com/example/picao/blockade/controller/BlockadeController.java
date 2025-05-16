package com.example.picao.blockade.controller;

import com.example.picao.blockade.dto.BlockadeRequestDTO;
import com.example.picao.blockade.dto.UpdateBlockadeRequest;
import com.example.picao.blockade.service.BlockadeService;
import com.example.picao.core.util.dto.GenericResponseDTO;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

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

    @PutMapping(value = "update")
    public ResponseEntity<GenericResponseDTO> update(@RequestBody @Valid UpdateBlockadeRequest requestDTO) {
        return GenericResponseDTO.genericResponse(blockadeService.update(requestDTO));
    }

    @DeleteMapping(value = "delete-by-id/{blockadeId}")
    public ResponseEntity<GenericResponseDTO> delete(@PathVariable() UUID blockadeId) {
        return GenericResponseDTO.genericResponse(blockadeService.delete(blockadeId));
    }
}
