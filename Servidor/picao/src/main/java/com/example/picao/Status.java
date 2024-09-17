package com.example.picao;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "statuses")
public class Status {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(name = "description", length = 20)
    private String description;

}