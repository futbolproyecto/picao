package com.example.picao.blockade.service.impl;

import com.example.picao.agenda.entity.DayOfWeek;
import com.example.picao.blockade.dto.BlockadeRequestDTO;
import com.example.picao.blockade.dto.BlockadeResponseDTO;
import com.example.picao.blockade.dto.UpdateBlockadeRequestDTO;
import com.example.picao.blockade.dto.projection.BlockeadeProjection;
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

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;
import java.util.stream.Collectors;

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

                            validateDuplicateLock(conflicts, field.getName(), date,
                                    blockadeRequestDTO.startTime(), blockadeRequestDTO.endTime());

                            return Blockade.builder()
                                    .date(date)
                                    .startTime(blockadeRequestDTO.startTime())
                                    .endTime(blockadeRequestDTO.endTime())
                                    .dayOfWeek(DayOfWeek.fromId(date.getDayOfWeek().getValue()))
                                    .field(field)
                                    .recordId(uuid)
                                    .build();

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
            List<BlockeadeProjection> data = blockadeRepository.findByUserId(userId);

            Map<UUID, EstablishmentResponseDTO> establishmentMap = new LinkedHashMap<>();

            for (BlockeadeProjection row : data) {

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

    @Transactional
    @Override
    public String update(UpdateBlockadeRequestDTO requestDTO) {
        try {
            UUID recordId = requestDTO.id();

            // Obtener y validar que existen bloqueos para ese recordId
            List<Blockade> existingBlockades = blockadeRepository.findByRecordId(recordId);
            if (existingBlockades.isEmpty()) {
                throw new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Bloqueo");
            }

            // Eliminar todos los bloqueos actuales
            blockadeRepository.deleteAll(existingBlockades);

            List<Blockade> nuevosBloqueos = new ArrayList<>();

            for (BlockadeRequestDTO blockadeRequestDTO : requestDTO.blockades()) {

                Field field = fieldRepository.findById(blockadeRequestDTO.fieldId())
                        .orElseThrow(() -> new AppException(
                                ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Cancha"));

                for (LocalDate date : blockadeRequestDTO.days()) {

                    // Validar conflictos antes de crear
                    Blockade conflict = blockadeRepository.findConflictingBlockadesUpdate(
                            field.getId(), date, blockadeRequestDTO.startTime(),
                            blockadeRequestDTO.endTime(), recordId);

                    validateDuplicateLock(conflict, field.getName(), date,
                            blockadeRequestDTO.startTime(), blockadeRequestDTO.endTime());

                    // Crear nuevo bloqueo
                    nuevosBloqueos.add(Blockade.builder()
                            .date(date)
                            .startTime(blockadeRequestDTO.startTime())
                            .endTime(blockadeRequestDTO.endTime())
                            .dayOfWeek(DayOfWeek.fromId(date.getDayOfWeek().getValue()))
                            .recordId(recordId)
                            .field(field)
                            .build());
                }
            }

            blockadeRepository.saveAll(nuevosBloqueos);

            return "Bloqueos actualizados";

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }
    }

    @Override
    public String delete(UUID blockadeId) {

        try {
            List<Blockade> existingBlockades = blockadeRepository.findByRecordId(blockadeId);

            if (existingBlockades.isEmpty()) {
                throw new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Bloqueo");
            }
            blockadeRepository.deleteAll(existingBlockades);

            return "Bloqueo eliminado";

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }
    }

    @Override
    public List<FieldResponseDTO> getById(UUID blockadeId) {
        try {
            List<BlockeadeProjection> projections = blockadeRepository.findByRecordIdField(blockadeId);

            Map<UUID, List<BlockeadeProjection>> fieldGrouped = projections.stream()
                    .collect(Collectors.groupingBy(BlockeadeProjection::getFieldId));

            List<FieldResponseDTO> result = new ArrayList<>();

            for (Map.Entry<UUID, List<BlockeadeProjection>> entry : fieldGrouped.entrySet()) {
                UUID fieldId = entry.getKey();
                List<BlockeadeProjection> fieldProjections = entry.getValue();

                String fieldName = fieldProjections.get(0).getFieldName();

                // Agrupar bloqueos por hora (startTime, endTime)
                Map<String, List<BlockeadeProjection>> blockadeGrouped = fieldProjections.stream()
                        .collect(Collectors.groupingBy(p -> p.getStartTime() + "-" + p.getEndTime()));

                List<BlockadeResponseDTO> blockades = new ArrayList<>();

                for (List<BlockeadeProjection> group : blockadeGrouped.values()) {
                    LocalTime startTime = group.get(0).getStartTime();
                    LocalTime endTime = group.get(0).getEndTime();

                    // Calcular fechas mínima y máxima
                    LocalDate startDate = group.stream()
                            .map(BlockeadeProjection::getDate)
                            .min(LocalDate::compareTo)
                            .orElse(null);

                    LocalDate endDate = group.stream()
                            .map(BlockeadeProjection::getDate)
                            .max(LocalDate::compareTo)
                            .orElse(null);

                    // se agrupan dias
                    List<DayOfWeek> daysOfWeek = group.stream()
                            .map(BlockeadeProjection::getDayOfWeek)
                            .distinct()
                            .sorted()
                            .toList();


                    BlockadeResponseDTO blockade = new BlockadeResponseDTO();
                    blockade.setId(blockadeId);
                    blockade.setStartTime(startTime);
                    blockade.setEndTime(endTime);
                    blockade.setStartDate(startDate);
                    blockade.setEndDate(endDate);
                    blockade.setDaysOfWeek(daysOfWeek);

                    blockades.add(blockade);
                }

                FieldResponseDTO fieldDTO = new FieldResponseDTO();
                fieldDTO.setId(fieldId);
                fieldDTO.setName(fieldName);
                fieldDTO.setBlockades(blockades);

                result.add(fieldDTO);
            }

            return result;

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }
    }

    private void validateDuplicateLock(Blockade blockade, String fielName, LocalDate date,
                                       LocalTime startTime, LocalTime endTime) {

        if (blockade != null) {
            throw new AppException(ErrorMessages.DUPLICATE_BLOCKADE, HttpStatus.CONFLICT,
                    fielName, date, startTime, endTime);
        }
    }


}
