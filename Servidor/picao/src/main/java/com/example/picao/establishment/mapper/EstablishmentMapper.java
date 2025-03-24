package com.example.picao.establishment.mapper;

import com.example.picao.city.mapper.CityMapper;
import com.example.picao.department.mapper.DepartmentMapper;
import com.example.picao.establishment.dto.CreateEstablishmentRequestDTO;
import com.example.picao.establishment.dto.EstablishmentResponseDTO;
import com.example.picao.establishment.entity.Establishment;
import com.example.picao.user.mapper.UserMapper;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;


@Mapper(uses = {UserMapper.class, DepartmentMapper.class, CityMapper.class})
public interface EstablishmentMapper {

    Establishment toEstablishment(CreateEstablishmentRequestDTO requestDTO);

    @Mapping(target = "users", ignore = true)
    @Mapping(target = "department.cities", ignore = true)
    EstablishmentResponseDTO toEstablishmentResponseDTO(Establishment establishment);



}
