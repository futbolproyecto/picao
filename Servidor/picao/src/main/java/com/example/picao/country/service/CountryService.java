package com.example.picao.country.service;

import com.example.picao.country.dto.CountryResponseDTO;
import java.util.List;

public interface CountryService {

    List<CountryResponseDTO> getCountries();
}
