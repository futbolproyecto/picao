package com.example.picao.country.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.country.service.CountryService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/country")
public class CountryController {

    private final CountryService countryService;

    @GetMapping(value = "get-all")
    public ResponseEntity<GenericResponseDTO> getAll() {
        return GenericResponseDTO.genericResponse(countryService.getCountries());
    }
}
