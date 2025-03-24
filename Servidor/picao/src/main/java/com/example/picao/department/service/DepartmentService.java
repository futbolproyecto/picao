package com.example.picao.department.service;


import com.example.picao.department.dto.DepartmentResponseDTO;

import java.util.List;

public interface DepartmentService {

    List<DepartmentResponseDTO> getAllDepartments();

    DepartmentResponseDTO getDepartmentById(int id);

}
