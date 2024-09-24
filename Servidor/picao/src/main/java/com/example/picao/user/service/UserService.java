package com.example.picao.user.service;

import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.dto.UserResponseDTO;

public interface UserService {

    UserResponseDTO createUser(CreateUserRequestDTO createUserRequestDTO);
}
