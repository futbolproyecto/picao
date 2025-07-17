package com.example.picao.agenda.repository;

import com.example.picao.agenda.dto.AgendaResponseDTO;
import com.example.picao.agenda.entity.Agenda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;
import java.util.UUID;

@Repository
public interface AgendaRepository extends JpaRepository<Agenda, UUID>, JpaSpecificationExecutor<Agenda> {

    @Query(value = "SELECT a FROM Agenda a " +
            "JOIN a.field f " +
            "JOIN  f.establishment e " +
            "WHERE e.id = :establishmentId")
    List<Agenda> findByEstablishmentId(UUID establishmentId);


    @Query(value = "SELECT new com.example.picao.agenda.dto.AgendaResponseDTO(a.id,a.date,a.startTime,a.status, " +
            "a.dayOfWeek, f.name,f.id, u.id, u.name, u.lastName, u.mobileNumber ) " +
            "FROM Agenda a " +
            "JOIN a.user u " +
            "JOIN a.field f " +
            "JOIN f.establishment e " +
            "WHERE e.id = :establishmentId AND a.status <> 'DISPONIBLE'")
    Set<AgendaResponseDTO> findByReserveByEstablishmentId(UUID establishmentId);

}
