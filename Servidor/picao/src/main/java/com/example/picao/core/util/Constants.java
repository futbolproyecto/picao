package com.example.picao.core.util;

public class Constants {
    private Constants() {
        throw new IllegalStateException("clase de utilidad");
    }

    public static final String REGEX_EMAIL = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
    public static final String VALIDATE_PHONE_NUMBER = "El numero celular debe tener minimo 10 caracteres";
    public static final String VALIDATE_PASSWORD = "la contrasena debe tener minimo 6 caracteres";
}
