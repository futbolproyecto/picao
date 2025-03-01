package com.example.picao.user.service;

import com.example.picao.user.dto.*;

import java.util.List;

public interface UserService {

    UserResponseDTO createUser(CreateUserRequestDTO createUserRequestDTO);

    int changePassword(ChangePasswordRequestDTO changePasswordRequestDTO);

    UserResponseDTO getUserById(int id);

    UserResponseDTO getByMobileNumber(String mobileNumber);

    List<UserResponseDTO> getAll();

    UserResponseDTO update(UpdateUserRequestDTO requestDTO);

    int setPassword(SetPasswordRequestDTO setPasswordRequestDTO);

}
