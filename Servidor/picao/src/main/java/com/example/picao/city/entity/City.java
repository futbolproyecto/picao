package com.example.picao.city.entity;

import com.example.picao.department.entity.Department;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Entity
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "cities")
@NoArgsConstructor()
public class City {

    @Id
    Integer id;

    @Column(length = 100)
    String name;

    @ManyToOne(fetch = FetchType.LAZY)
    Department department;

    public City(Integer id) {
        this.id = id;
    }
}
