package com.example.picao.core.util.mapper;

import com.example.picao.authentication.dto.AuthResponseDTO;
import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.dto.UserResponseDTO;
import com.example.picao.user.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper(uses = {RoleMapper.class})
public interface UserMapper {

    UserMapper USER = Mappers.getMapper(UserMapper.class);

    AuthResponseDTO toAuthResponseDTO(User user);

    User toUser(CreateUserRequestDTO createUserRequestDTO);

    UserResponseDTO toUserResponseDTO(User User);
}
