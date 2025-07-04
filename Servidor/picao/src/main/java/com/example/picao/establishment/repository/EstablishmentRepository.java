package com.example.picao.establishment.repository;

import com.example.picao.establishment.dto.EstablishmentOptionDTO;
import com.example.picao.establishment.entity.Establishment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;


@Repository
public interface EstablishmentRepository extends JpaRepository<Establishment, UUID> {

    Optional<Establishment> findByName(String name);

    Optional<Establishment> findByMobileNumber(String mobileNumber);

    List<Establishment> findByOwnerUserId(Integer userId);

    List<Establishment> findByCityId(Integer cityId);




}
