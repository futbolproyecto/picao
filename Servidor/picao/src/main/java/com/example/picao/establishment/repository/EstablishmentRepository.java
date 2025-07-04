package com.example.picao.establishment.repository;

import com.example.picao.establishment.dto.EstablishmentResponseDTO;
import com.example.picao.establishment.entity.Establishment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;


@Repository
public interface EstablishmentRepository extends JpaRepository<Establishment, UUID> {

    Optional<Establishment> findByName(String name);

    Optional<Establishment> findByMobileNumber(String mobileNumber);

    List<Establishment> findByOwnerUserId(Integer userId);

    @Query(value = "SELECT new com.example.picao.establishment.dto.EstablishmentResponseDTO(" +
            " e.id, e.name) FROM Establishment e " +
            "WHERE e.city.id = :cityId")
    List<EstablishmentResponseDTO> findByCityId(Integer cityId);


}
