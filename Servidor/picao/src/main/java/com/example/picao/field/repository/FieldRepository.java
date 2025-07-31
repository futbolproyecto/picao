package com.example.picao.field.repository;

import com.example.picao.field.dto.FieldResponseDTO;
import com.example.picao.field.entity.Field;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface FieldRepository extends JpaRepository<Field, UUID> {

    Optional<Field> findByNameAndEstablishmentId(String name, UUID establishmentId);

    @Query(value = "SELECT new com.example.picao.field.dto.FieldResponseDTO(" +
            " f.id, f.name, f.capacity, f.isAvailable, f.isRoofed) FROM Field  " +
            "f JOIN  f.establishment e WHERE e.id = :establishmentId")
    List<FieldResponseDTO> findByEstablishmentId(UUID establishmentId);

    @Query(value = "SELECT f FROM Field f " +
            "JOIN  f.establishment e WHERE e.id = :establishmentId")
    List<Field> findAgendasByEstablishmentId(UUID establishmentId);
}

