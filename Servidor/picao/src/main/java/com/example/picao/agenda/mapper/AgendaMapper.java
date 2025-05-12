package com.example.picao.agenda.mapper;

import com.example.picao.agenda.dto.AgendaResponseDTO;
import com.example.picao.agenda.entity.Agenda;
import com.example.picao.field.mapper.FieldMapper;
import org.mapstruct.Mapper;

@Mapper(uses = {FieldMapper.class})
public interface AgendaMapper {

    AgendaResponseDTO toAgendaResponseDTO(Agenda agenda);
}
