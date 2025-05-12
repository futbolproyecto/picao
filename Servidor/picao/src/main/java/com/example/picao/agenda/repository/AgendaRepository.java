package com.example.picao.agenda.repository;

import com.example.picao.agenda.entity.Agenda;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.UUID;

@Repository
public interface AgendaRepository extends JpaRepository<Agenda, UUID> {

    boolean existsByFieldIdAndDate(UUID fieldId, LocalDate date);
}
