package com.example.picao.user.entity;

import com.example.picao.player_profile.entity.PlayerProfile;
import com.example.picao.role.entity.Role;
import com.example.picao.Status;
import com.example.picao.team.entity.Team;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.experimental.FieldDefaults;

import java.time.LocalDate;
import java.util.List;
import java.util.Set;

@Getter
@Setter
@Entity
@FieldDefaults(level = AccessLevel.PRIVATE)
@Table(name = "users")
@NoArgsConstructor()
public class UserEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    Integer id;

    @Column(length = 50, unique = true)
    String username;

    @Column(nullable = false)
    String password;

    @Column(length = 50, nullable = false)
    String name;

    @Column(length = 50)
    String secondName;

    @Column(length = 50, nullable = false)
    String lastName;

    @Column(length = 50)
    String secondLastName;

    @Column(length = 20, unique = true, nullable = false)
    String mobileNumber;

    @Column(length = 80, unique = true, nullable = false)
    String email;

    @ManyToMany(fetch = FetchType.EAGER, cascade = {CascadeType.DETACH, CascadeType.MERGE, CascadeType.PERSIST,
            CascadeType.REFRESH})
    @JoinTable(name = "user_roles",
            joinColumns = @JoinColumn(
                    name = "user_id"), inverseJoinColumns = @JoinColumn(name = "role_id"))
    Set<Role> roles;

    LocalDate dateOfBirth;

    @OneToOne(mappedBy = "user", cascade = CascadeType.ALL)
    PlayerProfile playerProfile;

    public UserEntity(Integer id) {
        this.id = id;
    }
}