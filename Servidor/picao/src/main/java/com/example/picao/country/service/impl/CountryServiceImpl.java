package com.example.picao.country.service.impl;

import com.example.picao.core.exception.AppException;
import com.example.picao.country.dto.CountryResponseDTO;
import com.example.picao.country.mapper.CountryMapper;
import com.example.picao.country.repository.CountryRepository;
import com.example.picao.country.service.CountryService;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor()
@Service
public class CountryServiceImpl implements CountryService {

    private static final CountryMapper MAPPER = Mappers.getMapper(CountryMapper.class);
    private final CountryRepository countryRepository;

    @Transactional(readOnly = true)
    @Override
    public List<CountryResponseDTO> getCountries() {
        try {
            return countryRepository.findAll().stream().map(MAPPER::toCountryResponseDTO).toList();

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }
}
