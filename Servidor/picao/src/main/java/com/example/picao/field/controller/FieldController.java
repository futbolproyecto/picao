package com.example.picao.field.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.field.dto.CreateFieldRequestDTO;
import com.example.picao.field.service.FieldService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@AllArgsConstructor
@RequestMapping("/field")
public class FieldController {

    private final FieldService fieldService;

    @PostMapping(value = "create")
    public ResponseEntity<GenericResponseDTO> create(
            @RequestBody @Valid CreateFieldRequestDTO requestDTO) {
        return GenericResponseDTO.genericResponse(fieldService.create(requestDTO));
    }

    @GetMapping(value = "get-by-establishment-id/{establishmentId}")
    public ResponseEntity<GenericResponseDTO> getByOwnerUserId(@PathVariable() UUID establishmentId) {
        return GenericResponseDTO.genericResponse(fieldService.getByEstablishmentId(establishmentId));
    }
}
