package com.example.picao.department.entity;

import com.example.picao.city.entity.City;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Getter
@Setter
@Entity
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "departments")
public class Department {

    @Id
    Integer id;

    @Column(length = 100)
    String name;

    @OneToMany(mappedBy = "department", fetch = FetchType.LAZY)
    List<City> cities;
}
