package com.example.picao.agenda.repository;

import com.example.picao.agenda.entity.Agenda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Repository
public interface AgendaRepository extends JpaRepository<Agenda, UUID>, JpaSpecificationExecutor<Agenda> {


    boolean existsByFieldIdAndDate(UUID fieldId, LocalDate date);

    @Query(value = "SELECT a FROM Agenda a " +
            "JOIN a.field f " +
            "JOIN  f.establishment e " +
            "WHERE e.id = :establishmentId")
    List<Agenda> findByEstablishmentId(UUID establishmentId);


}
