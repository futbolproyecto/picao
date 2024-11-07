package com.example.picao.user.mapper;

import com.example.picao.authentication.dto.AuthResponseDTO;
import com.example.picao.role.mapper.RoleMapper;
import com.example.picao.user.dto.CreateUserRequestDTO;
import com.example.picao.user.dto.UserResponseDTO;
import com.example.picao.user.entity.UserEntity;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper(uses = {RoleMapper.class})
public interface UserMapper {

    UserMapper USER = Mappers.getMapper(UserMapper.class);

    AuthResponseDTO toAuthResponseDTO(UserEntity userEntity);

    UserEntity toUser(CreateUserRequestDTO createUserRequestDTO);

    UserResponseDTO toUserResponseDTO(UserEntity userEntity);
}
