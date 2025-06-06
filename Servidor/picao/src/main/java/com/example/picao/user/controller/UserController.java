package com.example.picao.user.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.user.dto.*;
import com.example.picao.user.service.UserService;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


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

    @PutMapping(value = "change-password")
    public ResponseEntity<GenericResponseDTO> changePassword(
            @RequestBody @Valid ChangePasswordRequestDTO requestDTO) {
        return GenericResponseDTO.genericResponse(userService.changePassword(requestDTO));
    }

    @GetMapping(value = "get-by-id/{id}")
    public ResponseEntity<GenericResponseDTO> getById(
            @PathVariable Integer id) {
        return GenericResponseDTO.genericResponse(userService.getById(id));
    }

    @GetMapping(value = "get-by-mobile-number/{mobileNumber}")
    public ResponseEntity<GenericResponseDTO> getPlayerMobileNumber(
            @PathVariable String mobileNumber) {

        return GenericResponseDTO.genericResponse(userService.getByMobileNumber(mobileNumber));
    }

    @GetMapping(value = "get-all")
    public ResponseEntity<GenericResponseDTO> getAll() {
        return GenericResponseDTO.genericResponse(userService.getAll());
    }

    @PutMapping(value = "update")
    public ResponseEntity<GenericResponseDTO> update(@RequestBody @Valid UpdateUserRequestDTO requestDTO) {
        return GenericResponseDTO.genericResponse(userService.update(requestDTO));
    }

    @PutMapping(value = "set-password")
    public ResponseEntity<GenericResponseDTO> setPassword(
            @RequestBody @Valid SetPasswordRequestDTO setPasswordRequestDTO) {
        return GenericResponseDTO.genericResponse(userService.setPassword(setPasswordRequestDTO));
    }

}
