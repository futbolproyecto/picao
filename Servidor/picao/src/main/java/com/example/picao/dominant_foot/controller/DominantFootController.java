package com.example.picao.dominant_foot.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.dominant_foot.service.DominantFootService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/dominant-foot")
public class DominantFootController {
    private final DominantFootService dominantFootService;

    @GetMapping(value = "get-all")
    public ResponseEntity<GenericResponseDTO> getAll() {
        return GenericResponseDTO.genericResponse(dominantFootService.getDominantFoot());
    }

}
