package com.example.picao.city.entity;

import com.example.picao.department.entity.Department;
import com.fasterxml.jackson.annotation.JsonBackReference;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Entity
@FieldDefaults(level = AccessLevel.PRIVATE)
    @Table(name = "cities")
    public class City {

        @Id
        Integer id;

        @Column(length = 100)
        String name;

        @ManyToOne(fetch = FetchType.LAZY)
        @JsonBackReference
        Department department;
    }
