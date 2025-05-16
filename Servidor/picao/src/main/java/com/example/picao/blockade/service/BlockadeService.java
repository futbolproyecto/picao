package com.example.picao.blockade.service;

import com.example.picao.blockade.dto.BlockadeRequestDTO;
import com.example.picao.blockade.dto.UpdateBlockadeRequest;
import com.example.picao.establishment.dto.EstablishmentResponseDTO;

import java.util.List;
import java.util.UUID;

public interface BlockadeService {

    String create(List<BlockadeRequestDTO> requestDTO);

    List<EstablishmentResponseDTO> getByUserId(Integer blockadeId);

    String update(UpdateBlockadeRequest request);

    String delete(UUID blockadeId);


}
