package com.example.picao.agenda.service;

import com.example.picao.agenda.dto.CreateAgendaRequestDTO;

import java.util.List;

public interface AgendaService {


    String create(List<CreateAgendaRequestDTO> createAgendaRequestDTO);
}
