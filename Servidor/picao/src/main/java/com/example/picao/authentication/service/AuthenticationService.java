package com.example.picao.authentication.service;

import com.example.picao.authentication.dto.AuthResponseDTO;
import com.example.picao.authentication.dto.LoginRequestDTO;

public interface AuthenticationService {

    AuthResponseDTO login(LoginRequestDTO loginRequestDTO);
}
