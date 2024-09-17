package com.example.picao;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "profiles")
public class Profile {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "rol_id")
    private com.example.picao.Role rol;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "modul_id")
    private Module modul;

}