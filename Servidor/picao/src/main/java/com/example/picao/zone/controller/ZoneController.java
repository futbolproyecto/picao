package com.example.picao.zone.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.zone.service.ZoneService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/zone")
public class ZoneController {
    private final ZoneService zoneService;

    @GetMapping(value = "get-all")
    public ResponseEntity<GenericResponseDTO> getAll() {
        return GenericResponseDTO.genericResponse(zoneService.getZones());
    }

}
