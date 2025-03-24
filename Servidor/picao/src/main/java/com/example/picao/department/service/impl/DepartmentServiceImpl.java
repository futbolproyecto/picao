package com.example.picao.department.service.impl;

import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.department.dto.DepartmentResponseDTO;
import com.example.picao.department.entity.Department;
import com.example.picao.department.mapper.DepartmentMapper;
import com.example.picao.department.repository.DepartmentRepository;
import com.example.picao.department.service.DepartmentService;
import lombok.AllArgsConstructor;
import org.mapstruct.factory.Mappers;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@AllArgsConstructor()
@Service
public class DepartmentServiceImpl implements DepartmentService {

    private static final DepartmentMapper MAPPER = Mappers.getMapper(DepartmentMapper.class);

    private final DepartmentRepository departmentRepository;

    @Transactional(readOnly = true)
    @Override
    public List<DepartmentResponseDTO> getAllDepartments() {
        return departmentRepository.findDepartments();
    }

    @Transactional(readOnly = true)
    @Override
    public DepartmentResponseDTO getDepartmentById(int id) {

        Department department = departmentRepository.findById(id).orElseThrow(
                () -> new AppException(ErrorMessages.DEPARTMENT_NOT_EXIST, HttpStatus.NOT_FOUND));

        return MAPPER.toDepartmentCitiesResponseDTO(department);
    }
}
