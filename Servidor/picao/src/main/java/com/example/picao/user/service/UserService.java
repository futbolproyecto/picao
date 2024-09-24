package com.example.picao.user.service;

import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.dto.UserResponseDTO;

/**
 * Clase Service para definir los metodos a usar relacionados al usuario
 */

public interface UserService {

    UserResponseDTO createUser(CreateUserRequestDTO createUserRequestDTO);
}
