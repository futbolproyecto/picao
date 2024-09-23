package com.example.picao.core.util;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ErrorMessages {
    AUTHENTICATION_ERROR("Usuario o contraseña invalidos",
            "Verifique la informacion ingresada",
            "E1"),

    UNHANDLED_ERROR("Error desconocido",
            "Contacte el administrador del sistema",
            "E2");

    private final String message;
    private final String recommendation;
    private final String code;

}
