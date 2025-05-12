package com.example.picao.field.service.impl;

import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.establishment.entity.Establishment;
import com.example.picao.establishment.repository.EstablishmentRepository;
import com.example.picao.field.dto.CreateFieldRequestDTO;
import com.example.picao.field.dto.FieldResponseDTO;
import com.example.picao.field.entity.Field;
import com.example.picao.field.mapper.FieldMapper;
import com.example.picao.field.repository.FieldRepository;
import com.example.picao.field.service.FieldService;
import lombok.RequiredArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;

@RequiredArgsConstructor()
@Service
public class FieldServiceImpl implements FieldService {

    private static final FieldMapper MAPPER = Mappers.getMapper(FieldMapper.class);
    private final FieldRepository fieldRepository;
    private final EstablishmentRepository establishmentRepository;

    @Transactional
    @Override
    public FieldResponseDTO create(CreateFieldRequestDTO requestDTO) {
        try {

            Establishment establishment = establishmentRepository.findById(requestDTO.establishmentId()).orElseThrow(
                    () -> new AppException(ErrorMessages.GENERIC_NOT_EXIST, HttpStatus.NOT_FOUND, "Establecimiento"));

            fieldRepository.findByName(requestDTO.name()).ifPresent(
                    field -> {
                        throw new AppException(
                                ErrorMessages.GENERIC_DUPLICATE, HttpStatus.NOT_FOUND, "Nombre de la cancha");
                    });


            Field field = MAPPER.toField(requestDTO);
            field.setEstablishment(establishment);

            return MAPPER.toFieldResponseDto(fieldRepository.save(field));

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus(), e.getArgs());
        }
    }

    @Transactional(readOnly = true)
    @Override
    public List<FieldResponseDTO> getByEstablishmentId(UUID establishmentId) {

        try {
            return fieldRepository.findByEstablishmentId(establishmentId);

        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }
    }

    @Override
    public List<FieldResponseDTO> getAgendasByEstablishmentId(UUID establishmentId) {

        try {
            return fieldRepository.findAgendasByEstablishmentId(establishmentId)
                    .stream().map(MAPPER::toFieldResponseDto).toList();
        } catch (AppException e) {
            throw new AppException(e.getErrorMessages(), e.getHttpStatus());
        }

    }
}
