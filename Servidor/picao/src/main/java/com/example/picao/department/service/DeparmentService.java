package com.example.picao.department.service;


import com.example.picao.department.dto.DepartmentResponseDTO;
import com.example.picao.department.entity.Department;

import java.util.List;

public interface DeparmentService {

    List<DepartmentResponseDTO> getAllDepartments();

    Department getDepartmentById(int id);

}
