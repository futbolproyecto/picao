package com.example.picao.department.repository;

import com.example.picao.department.dto.DepartmentResponseDTO;
import com.example.picao.department.entity.Department;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface DepartmentRepository extends JpaRepository<Department, Integer> {

    Optional<Department> findById(int id);

    @Query(value = "SELECT new com.example.picao.department.dto.DepartmentResponseDTO(" +
            "d.id, d.name) FROM Department d")
    List<DepartmentResponseDTO> findDepartments();
}
