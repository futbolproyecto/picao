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
            "E5");

    private final String message;
    private final String recommendation;
    private final String code;

}
