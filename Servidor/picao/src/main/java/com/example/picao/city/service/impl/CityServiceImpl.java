package com.example.picao.city.service.impl;

import com.example.picao.city.entity.City;
import com.example.picao.city.repository.CityRepository;
import com.example.picao.city.service.CityService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


@RequiredArgsConstructor()
@Service
public class CityServiceImpl implements CityService {
    private final CityRepository cityRepository;

    @Transactional(readOnly = true)
    @Override
    public List<City> getCities() {
        return cityRepository.findAll();
    }
}
