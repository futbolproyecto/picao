package com.example.picao.department.service.impl;

import com.example.picao.core.exception.AppException;
import com.example.picao.core.util.ErrorMessages;
import com.example.picao.department.dto.DepartmentResponseDTO;
import com.example.picao.department.entity.Department;
import com.example.picao.department.repository.DepartmentRepository;
import com.example.picao.department.service.DeparmentService;
import lombok.AllArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@AllArgsConstructor()
@Service
public class DeparmentServiceImpl implements DeparmentService {

    private final DepartmentRepository departmentRepository;

    @Transactional(readOnly = true)
    @Override
    public List<DepartmentResponseDTO> getAllDepartments() {
        return departmentRepository.findDepartments();
    }

    @Transactional(readOnly = true)
    @Override
    public Department getDepartmentById(int id) {

        return departmentRepository.findById(id).orElseThrow(
                () -> new AppException(ErrorMessages.DEPARTMENT_NOT_EXIST, HttpStatus.NOT_FOUND));
    }
}
