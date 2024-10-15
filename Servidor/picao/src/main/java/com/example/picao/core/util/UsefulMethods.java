package com.example.picao.core.util;

import com.example.picao.role.entity.Role;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.Collection;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * metodos utilitarios se usan en diferentes clases
 */
public class UsefulMethods {

    private UsefulMethods() {
        throw new UnsupportedOperationException("esta clase es de utilidad, no puede ser instanciada");
    }

    public static Collection<GrantedAuthority> getAuthorities(Set<Role> roles) {
        return roles.stream().map(role -> new SimpleGrantedAuthority(role.getName().name()))
                .collect(Collectors.toSet());
    }




}
