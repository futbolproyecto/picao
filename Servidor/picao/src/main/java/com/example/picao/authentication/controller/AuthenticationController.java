package com.example.picao.authentication.controller;

import com.example.picao.authentication.dto.LoginRequestDTO;
import com.example.picao.authentication.service.AuthenticationService;
import com.example.picao.core.util.dto.GenericResponseDTO;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@AllArgsConstructor
@RequestMapping("/authentication")
public class AuthenticationController {

    private final AuthenticationService authenticationService;

    @PostMapping(value = "login")
    public ResponseEntity<GenericResponseDTO> login(
            @RequestBody LoginRequestDTO loginRequestDTO) {
        return GenericResponseDTO.genericResponse(authenticationService.login(loginRequestDTO));
    }
}
