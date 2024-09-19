package com.example.picao;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Getter
@Setter
@Entity
@Table(name = "statuses")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Status {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(name = "description", length = 20)
    private String description;

}