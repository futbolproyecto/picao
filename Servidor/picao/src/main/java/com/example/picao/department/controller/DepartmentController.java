package com.example.picao.department.controller;

import com.example.picao.core.util.dto.GenericResponseDTO;
import com.example.picao.department.service.DeparmentService;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/department")
public class DepartmentController {
    private final DeparmentService deparmentService;

    @GetMapping(value = "get-all")
    public ResponseEntity<GenericResponseDTO> getAll() {
        return GenericResponseDTO.genericResponse(deparmentService.getAllDepartments());
    }

    @GetMapping(value = "get-by-id/{id}")
    public ResponseEntity<GenericResponseDTO> getDepartmentId(@PathVariable("id") Integer id) {
        return GenericResponseDTO.genericResponse(deparmentService.getDepartmentById(id));
    }

}
