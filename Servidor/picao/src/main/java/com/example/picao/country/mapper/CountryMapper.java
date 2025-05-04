package com.example.picao.country.mapper;

import com.example.picao.country.dto.CountryResponseDTO;
import com.example.picao.country.entity.Country;
import org.mapstruct.Mapper;

@Mapper()
public interface CountryMapper {

    CountryResponseDTO toCountryResponseDTO(Country country);
}
