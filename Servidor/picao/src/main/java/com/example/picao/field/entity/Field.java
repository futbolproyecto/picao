package com.example.picao.field.entity;

import com.example.picao.agenda.entity.Agenda;
import com.example.picao.establishment.entity.Establishment;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.util.List;
import java.util.UUID;


@FieldDefaults(level = AccessLevel.PRIVATE)
@NoArgsConstructor()
@Getter
@Setter
@Table(name = "fields")
@Entity
public class Field {

    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    UUID id;

    @Column(length = 200, nullable = false)
    String name;

    @Column(length = 2, nullable = false)
    Integer capacity;

    @Column(nullable = false)
    Boolean isAvailable;

    @Column(nullable = false)
    Boolean isRoofed;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    Establishment establishment;

    @OneToMany(mappedBy = "field", fetch = FetchType.LAZY)
    List<Agenda> agendas;

}