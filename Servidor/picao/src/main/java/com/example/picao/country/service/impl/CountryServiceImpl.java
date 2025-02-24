package com.example.picao.country.service.impl;

import com.example.picao.country.entity.Country;
import com.example.picao.country.repository.CountryRepository;
import com.example.picao.country.service.CountryService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@RequiredArgsConstructor()
@Service
public class CountryServiceImpl implements CountryService {
    private final CountryRepository countryRepository;

    @Transactional(readOnly = true)
    @Override
    public List<Country> getCountries() {
        return countryRepository.findAll();
    }
}
