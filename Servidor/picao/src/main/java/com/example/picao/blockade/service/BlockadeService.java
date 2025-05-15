package com.example.picao.blockade.service;

import com.example.picao.blockade.dto.BlockadeRequestDTO;
import com.example.picao.establishment.dto.EstablishmentResponseDTO;

import java.util.List;

public interface BlockadeService {

    String create(List<BlockadeRequestDTO> requestDTO);

    List<EstablishmentResponseDTO> getByUserId(Integer blockadeId);


}
