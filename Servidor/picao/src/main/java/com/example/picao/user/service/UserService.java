package com.example.picao.user.service;

import com.example.picao.user.dto.ChangePasswordRequestDTO;
import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.dto.UserResponseDTO;

import java.util.List;

public interface UserService {

    UserResponseDTO createUser(CreateUserRequestDTO createUserRequestDTO);

    int changePassword(ChangePasswordRequestDTO changePasswordRequestDTO);

    UserResponseDTO getUserById(int id);

    UserResponseDTO getByMobileNumber(String mobileNumber);

    List<UserResponseDTO> getAll();

}
