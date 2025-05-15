package com.example.picao.establishment.service;

import com.example.picao.establishment.dto.CreateEstablishmentRequestDTO;
import com.example.picao.establishment.dto.EstablishmentResponseDTO;

import java.util.List;

public interface EstablishmentService {

    EstablishmentResponseDTO create(CreateEstablishmentRequestDTO requestDTO);

    List<EstablishmentResponseDTO> getByOwnerUserId(Integer userId);



}
