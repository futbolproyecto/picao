package com.example.picao.field.mapper;

import com.example.picao.agenda.mapper.AgendaMapper;
import com.example.picao.field.dto.CreateFieldRequestDTO;
import com.example.picao.field.dto.FieldResponseDTO;
import com.example.picao.field.entity.Field;
import org.mapstruct.Mapper;

@Mapper(uses = {AgendaMapper.class})
public interface FieldMapper {

    Field toField(CreateFieldRequestDTO requestDTO);

    FieldResponseDTO toFieldResponseDto(Field field);
}
