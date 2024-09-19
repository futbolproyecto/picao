package com.example.picao.user.entity;

import com.example.picao.City;
import com.example.picao.role.entity.Role;
import com.example.picao.Status;
import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.util.Set;

@Getter
@Setter
@Entity
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(length = 50, unique = true, nullable = false)
    String username;

    @Column(nullable = false)
    String password;

    @Column(name = "name", length = 50)
    String name;

    @Column(name = "second_name", length = 50)
    String secondName;

    @Column(name = "last_name", length = 50)
    String lastName;

    @Column(name = "second_last_name", length = 50)
    String secondLastName;

    @Column(name = "mobile_number", length = 20, unique = true, nullable = false)
    String mobileNumber;

    @Column(length = 80, unique = true, nullable = false)
    @Email(message = "correo invalido")
    String email;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "city_id")
    City city;

    @ManyToMany(fetch = FetchType.EAGER, cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST,
            CascadeType.REFRESH})
    @JoinTable(name = "user_roles",
            joinColumns = @JoinColumn(
                    name = "user_id"), inverseJoinColumns = @JoinColumn(name = "role_id"))
    Set<Role> roles;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "status_id")
    Status status;

}