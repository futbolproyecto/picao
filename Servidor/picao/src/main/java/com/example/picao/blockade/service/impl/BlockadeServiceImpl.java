package com.example.picao.blockade.service.impl;

import com.example.picao.agenda.entity.DayOfWeek;
import com.example.picao.blockade.dto.BlockadeRequestDTO;
import com.example.picao.blockade.dto.BlockadeResponseDTO;
import com.example.picao.blockade.dto.projection.BlockeadeByUserProjection;
import com.example.picao.blockade.entity.Blockade;
import com.example.picao.blockade.repository.BlockadeRepository;
import com.example.picao.blockade.service.BlockadeService;
import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.establishment.dto.EstablishmentResponseDTO;
import com.example.picao.field.dto.FieldResponseDTO;
import com.example.picao.field.entity.Field;
import com.example.picao.field.repository.FieldRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@RequiredArgsConstructor()
@Service
public class BlockadeServiceImpl implements BlockadeService {

    private final FieldRepository fieldRepository;
    private final BlockadeRepository blockadeRepository;

    @Transactional
    @Override
    public String create(List<BlockadeRequestDTO> requestDTO) {

        try {

            UUID uuid = UUID.randomUUID();

            for (BlockadeRequestDTO blockadeRequestDTO : requestDTO) {

                Field field = fieldRepository.findById(blockadeRequestDTO.fieldId())
                        .orElseThrow(() -> new AppException(
                                ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Cancha"));

                List<Blockade> bloqueos = blockadeRequestDTO.days().stream()
                        .map(date -> {

                            // se valida si ya existe este bloqueo generado
                            Blockade conflicts = blockadeRepository.findConflictingBlockades(
                                    field.getId(), date, blockadeRequestDTO.startTime(),
                                    blockadeRequestDTO.endTime());


                            if (conflicts != null) {
                                throw new AppException(ErrorMessages.DUPLICATE_BLOCKADE,
                                        HttpStatus.CONFLICT, field.getName(), date, blockadeRequestDTO.startTime(),
                                        blockadeRequestDTO.endTime());
                            }


                            Blockade bloqueo = new Blockade();
                            bloqueo.setDate(date);
                            bloqueo.setStartTime(blockadeRequestDTO.startTime());
                            bloqueo.setEndTime(blockadeRequestDTO.endTime());
                            bloqueo.setDayOfWeek(DayOfWeek.fromId(date.getDayOfWeek().getValue()));
                            bloqueo.setField(field);
                            bloqueo.setRecordId(uuid);
                            return bloqueo;
                        })
                        .toList();

                blockadeRepository.saveAll(bloqueos);

            }
            return "Bloqueos generados";

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }

    }

    @Transactional(readOnly = true)
    @Override
    public List<EstablishmentResponseDTO> getByUserId(Integer userId) {
        try {
            List<BlockeadeByUserProjection> data = blockadeRepository.findByUserId(userId);

            Map<UUID, EstablishmentResponseDTO> establishmentMap = new LinkedHashMap<>();

            for (BlockeadeByUserProjection row : data) {

                // 1. Agrupar por establecimiento
                EstablishmentResponseDTO establishment = establishmentMap.computeIfAbsent(
                        row.getEstablishmentId(),
                        id -> new EstablishmentResponseDTO(id, row.getEstablishmentName(), new ArrayList<>())
                );

                // 2. Buscar o crear cancha dentro del establecimiento
                List<FieldResponseDTO> fields = establishment.getFields();
                FieldResponseDTO field = fields.stream()
                        .filter(f -> f.getId().equals(row.getFieldId()))
                        .findFirst()
                        .orElseGet(() -> {
                            FieldResponseDTO newField = new FieldResponseDTO(
                                    row.getFieldId(), row.getFieldName(), new ArrayList<>());
                            fields.add(newField);
                            return newField;
                        });

                // 3. Buscar o crear bloqueo (agrupado por recordId)
                List<BlockadeResponseDTO> blockades = field.getBlockades();
                BlockadeResponseDTO blockade = blockades.stream()
                        .filter(b -> b.getId().equals(row.getRecordId()))
                        .findFirst()
                        .orElseGet(() -> {
                            BlockadeResponseDTO newBlockade = new BlockadeResponseDTO();
                            newBlockade.setId(row.getRecordId());
                            newBlockade.setStartTime(row.getStartTime());
                            newBlockade.setEndTime(row.getEndTime());
                            newBlockade.setStartDate(row.getDate());
                            newBlockade.setEndDate(row.getDate());
                            newBlockade.setDaysOfWeek(new ArrayList<>(List.of(row.getDayOfWeek())));
                            blockades.add(newBlockade);
                            return newBlockade;
                        });

                // 4. Actualizar datos del bloqueo
                if (row.getDate().isBefore(blockade.getStartDate())) {
                    blockade.setStartDate(row.getDate());
                }
                if (row.getDate().isAfter(blockade.getEndDate())) {
                    blockade.setEndDate(row.getDate());
                }
                if (!blockade.getDaysOfWeek().contains(row.getDayOfWeek())) {
                    blockade.getDaysOfWeek().add(row.getDayOfWeek());
                }
            }

            return new ArrayList<>(establishmentMap.values());

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }

    }
}
