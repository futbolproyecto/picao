package com.example.picao.establishment.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.establishment.dto.CreateEstablishmentRequestDTO;
import com.example.picao.establishment.service.EstablishmentService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/establishment")
public class EstablishmentController {

    private final EstablishmentService establishmentService;

    @PostMapping(value = "create")
    public ResponseEntity<GenericResponseDTO> create(
            @RequestBody @Valid CreateEstablishmentRequestDTO requestDTO) {
        return GenericResponseDTO.genericResponse(establishmentService.create(requestDTO));
    }

    @GetMapping(value = "get-by-owner-user-id/{userId}")
    public ResponseEntity<GenericResponseDTO> getByOwnerUserId(@PathVariable() int userId) {
        return GenericResponseDTO.genericResponse(establishmentService.getByOwnerUserId(userId));
    }

    @GetMapping("/get-by-city/{cityId}")
    public ResponseEntity<GenericResponseDTO> getByCity(@PathVariable Integer cityId) {

        return GenericResponseDTO.genericResponse(
                establishmentService.getByCity(cityId));
    }
}
