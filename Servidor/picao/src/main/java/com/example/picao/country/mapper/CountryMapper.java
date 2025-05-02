package com.example.picao.country.mapper;

import com.example.picao.country.dto.CountryResponseDTO;
import com.example.picao.country.entity.Country;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper()
public interface CountryMapper {

    CountryMapper COUNTRY = Mappers.getMapper(CountryMapper.class);

    CountryResponseDTO toCountryResponseDTO(Country country);
}
