package com.example.picao.user.entity;

import com.example.picao.City;
import com.example.picao.Role;
import com.example.picao.Status;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "users")
public class User {
    @Id
    @Column(name = "id", nullable = false)
    private Integer id;

    @Column(length = 50, unique = true, nullable = false)
    private String username;

    @Column()
    private String password;

    @Column(name = "name", length = 50)
    private String name;

    @Column(name = "second_name", length = 50)
    private String secondName;

    @Column(name = "last_name", length = 50)
    private String lastName;

    @Column(name = "second_last_name", length = 50)
    private String secondLastName;

    @Column(name = "mobile_number", length = 20, unique = true, nullable = false)
    private String mobileNumber;

    @Column(name = "email", length = 80, unique = true, nullable = false)
    private String email;


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "city_id")
    private City city;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "rol_id")
    private Role rol;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "status_id")
    private Status status;

}