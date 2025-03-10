package com.example.picao.city.repository;

import com.example.picao.city.dto.CityResponseDTO;
import com.example.picao.city.entity.City;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CityRepository extends JpaRepository<City, Integer> {
    @Query(value = "SELECT new com.example.picao.city.dto.CityResponseDTO(" +
            "d.id, d.name) FROM City d")
    List<CityResponseDTO> findCities();
}
