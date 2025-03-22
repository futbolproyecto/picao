package com.example.picao.field.repository;

import com.example.picao.field.entity.Field;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface FieldRepository extends JpaRepository<Field, UUID> {

    Optional<Field> findByName(String name);

    List<Field> findByEstablishmentId(UUID establishmentId);
}
