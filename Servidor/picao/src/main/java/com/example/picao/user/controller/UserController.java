package com.example.picao.user.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.service.UserService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * Clase controlador para administrar las peticiones HTTP
 */
@RestController
@AllArgsConstructor
@RequestMapping("/user")
public class UserController {

    private final UserService userService;

    @PostMapping(value = "create")
    public ResponseEntity<GenericResponseDTO> create(
            @RequestBody @Valid CreateUserRequestDTO createUserRequestDTO) {
        return GenericResponseDTO.genericResponse(userService.createUser(createUserRequestDTO));
    }

    @PostMapping(value = "recover-password/{email}")
    public ResponseEntity<GenericResponseDTO> recoverPassword(@PathVariable String email) {
        return GenericResponseDTO.genericResponse(userService.recoverPassword(email));
    }


}
