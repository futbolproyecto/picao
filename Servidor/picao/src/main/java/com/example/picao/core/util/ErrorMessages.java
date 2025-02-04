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
            "E2"),
    DUPLICATE_EMAIL("El correo electrónico ya se encuentra registrado",
            "Verifique la informacion ingresada",
            "E4"),
    DUPLICATE_PHONE_NUMBER("El numero de celular ya se encuentra registrado",
            "Verifique la informacion ingresada",
            "E5"),
    INVALID_PASSWORD_PATTERN("La contraseña debe tener al menos 6 caracteres, una letra mayúscula, una letra minúscula, un número y un carácter especial.",
            "Verifique la informacion ingresada",
            "E5"),
    INVALID_OTP("El código ingresado es incorrecto.",
            "Por favor, inténtalo nuevamente.",
            "E5"),
    OTP_EXPIRED("El OTP ingresado caduco.",
            "Solicite nuevamente el envio de un OTP",
            "E5"),
    PHONE_NUMBER_NOT_EXIST("Usuario no se encuentra registrado.",
            "Verifique la informacion ingresada",
            "E5"),
    GENERATED_OTP("Ya genero un otp para el celular indicado.",
            "Verifique el otp enviado o genere uno nuevo.",
            "E5"),
    EMAIL_DOES_NOT_EXIST("El correo electrónico proporcionado no está registrado",
            "Por favor, verifica e intenta de nuevo o crea una nueva cuenta.",
            "E4"),
    USER_NOT_EXIST("Usuario no se encuentra registrado.",
            "Verifique la informacion ingresada",
            "E5"),
    DEPARTMENT_NOT_EXIST("Departamento no se encuentra registrado.",
            "Verifique la informacion ingresada",
            "E5"),
    DUPLICATE_NIKCNAME("El alias ingresado ya existe",
            "Por favor, elige otro alias e inténtalo nuevamente",
            "E5"),
    GENERIC_NOT_EXIST("Informacion ingresada no existe en base de datos.",
            "Verifique la informacion ingresada",
            "E5"),
    DUPLICATE_TEAM_NAME("El nombre del equipo ya está registrado.",
            "Por favor, elige otro nombre e intenta nuevamente",
            "E5");
    private final String message;
    private final String recommendation;
    private final String code;

}
