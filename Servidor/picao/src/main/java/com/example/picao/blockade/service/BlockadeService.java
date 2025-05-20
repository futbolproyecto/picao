package com.example.picao.blockade.service;

import com.example.picao.blockade.dto.BlockadeRequestDTO;
import com.example.picao.blockade.dto.UpdateBlockadeRequestDTO;
import com.example.picao.establishment.dto.EstablishmentResponseDTO;
import com.example.picao.field.dto.FieldResponseDTO;

import java.util.List;
import java.util.UUID;

public interface BlockadeService {

    String create(List<BlockadeRequestDTO> requestDTO);

    List<EstablishmentResponseDTO> getByUserId(Integer blockadeId);

    String update(UpdateBlockadeRequestDTO request);

    String delete(UUID blockadeId);

    List<FieldResponseDTO> getById(UUID blockadeId);


}
