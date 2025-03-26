package com.example.picao.field.service;

import com.example.picao.field.dto.CreateFieldRequestDTO;
import com.example.picao.field.dto.FieldResponseDTO;

import java.util.List;
import java.util.UUID;

public interface FieldService {

    FieldResponseDTO create(CreateFieldRequestDTO requestDTO);

    List<FieldResponseDTO> getByEstablishmentId(UUID establishmentId);
}
