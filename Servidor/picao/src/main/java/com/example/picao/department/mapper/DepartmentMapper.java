package com.example.picao.department.mapper;

import com.example.picao.city.mapper.CityMapper;
import com.example.picao.department.dto.DepartmentResponseDTO;
import com.example.picao.department.entity.Department;
import org.mapstruct.Mapper;

@Mapper(uses = {CityMapper.class})
public interface DepartmentMapper {

    DepartmentResponseDTO toDepartmentCitiesResponseDTO(Department department);

}
