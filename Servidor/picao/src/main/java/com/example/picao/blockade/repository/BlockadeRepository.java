package com.example.picao.blockade.repository;

import com.example.picao.blockade.dto.projection.BlockeadeProjection;
import com.example.picao.blockade.entity.Blockade;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.UUID;

public interface BlockadeRepository extends JpaRepository<Blockade, UUID> {

    @Query(value = """
            SELECT e.id   AS establishment_id,
                   e.name AS establishment_name,
                   f.id   AS field_id,
                   f.name AS field_name,
                   a.id   AS agenda_id,
                   a.date AS date,
                   a.start_time AS startTime,
                   a.end_time AS endTime,
                   a.day_of_week AS dayOfWeek,
                   a.record_id AS recordId
            FROM establishments e
                     LEFT JOIN fields f ON f.establishment_id = e.id
                     LEFT JOIN blockades a ON a.field_id = f.id
            WHERE e.owner_user_id = :userId AND a.id IS NOT NULL
            """, nativeQuery = true)
    List<BlockeadeProjection> findByUserId(Integer userId);

    @Query("SELECT b FROM Blockade b WHERE b.field.id = :fieldId AND b.date = :day " +
            "AND b.startTime = :startTime AND b.endTime = :endTime")
    Blockade findConflictingBlockades(UUID fieldId, LocalDate day, LocalTime startTime, LocalTime endTime);

    @Query("SELECT b FROM Blockade b WHERE b.field.id = :fieldId AND b.date = :day " +
            "AND b.startTime = :startTime AND b.endTime = :endTime AND b.recordId != :recordId")
    Blockade findConflictingBlockadesUpdate(UUID fieldId, LocalDate day, LocalTime startTime, LocalTime endTime,
                                            UUID recordId);

    List<Blockade> findByRecordId(UUID recordId);

    @Query(value = """
            SELECT f.id   AS field_id,
                   f.name AS field_name,
                   b.id   AS agenda_id,
                   b.date AS date,
                   b.start_time AS startTime,
                   b.end_time AS endTime,
                   b.day_of_week AS dayOfWeek,
                   b.record_id AS recordId
            FROM  fields f
                LEFT JOIN blockades b ON b.field_id = f.id
                WHERE b.record_id = :recordId
            """, nativeQuery = true)
    List<BlockeadeProjection> findByRecordIdField(UUID recordId);

}
