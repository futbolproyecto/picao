package com.example.picao.city.mapper;

import com.example.picao.city.dto.CityResponseDTO;
import com.example.picao.city.entity.City;
import org.mapstruct.Mapper;

@Mapper()
public interface CityMapper {

    CityResponseDTO toCityResponseDTO(City city);
}
