package com.example.picao.core.util;

public class Constants {
    private Constants() {
        throw new IllegalStateException("clase de utilidad");
    }

    public static final String REGEX_EMAIL = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
    public static final String ERROR_MESSAGE_PHONE_NUMBER = "debe tener minimo 10 caracteres";
    public static final String ERROR_MESSAGE_PASSWORD = "debe tener al menos 6 caracteres, una letra mayúscula, una letra minúscula, un número y un carácter especial.";
        public static final String PASSWORD_PATTERN = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&.\\-_])[A-Za-z\\d@$!%*?&.\\-_]{6,}$";
    public static final String ERROR_MESSAGE_EMAIL = "no es valido";

    /**
     * rutas sin seguridad
     */
    public static final String[] UNSAFE_ROUTES = {
            "/authentication/login",
            "/user/create"
    };
}
