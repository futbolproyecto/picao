package com.example.picao.user.mapper;

import com.example.picao.authentication.dto.AuthResponseDTO;
import com.example.picao.role.mapper.RoleMapper;
import com.example.picao.user.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper(uses = {RoleMapper.class})
public interface UserMapper {

    UserMapper USER = Mappers.getMapper(UserMapper.class);

    AuthResponseDTO toAuthResponseDTO(User user);
}
