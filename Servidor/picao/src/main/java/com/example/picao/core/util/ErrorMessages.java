package com.example.picao.core.util;

import lombok.AllArgsConstructor;
import lombok.Getter;

import java.util.MissingFormatArgumentException;

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
            "E6"),
    INVALID_OTP("El código ingresado es incorrecto.",
            "Por favor, inténtalo nuevamente.",
            "E7"),
    OTP_EXPIRED("El OTP ingresado caduco.",
            "Solicite nuevamente el envio de un OTP",
            "E8"),
    PHONE_NUMBER_NOT_EXIST("No se ha encontrado un jugador con este número de celular.",
            "Verifica el número o invita a esta persona a unirse a la aplicación.",
            "E9"),
    GENERATED_OTP("Ya genero un otp para el celular indicado.",
            "Verifique el otp enviado o genere uno nuevo.",
            "E10"),
    EMAIL_DOES_NOT_EXIST("El correo electrónico proporcionado no está registrado",
            "Por favor, verifica e intenta de nuevo o crea una nueva cuenta.",
            "E11"),
    USER_NOT_EXIST("Usuario no se encuentra registrado.",
            "Verifique la informacion ingresada",
            "E12"),
    DEPARTMENT_NOT_EXIST("Departamento no se encuentra registrado.",
            "Verifique la informacion ingresada",
            "E13"),
    DUPLICATE_NIKCNAME("El alias ingresado ya existe",
            "Por favor, elige otro alias e inténtalo nuevamente",
            "E14"),
    GENERIC_NOT_EXIST("%s no existe en base de datos.",
            "Verifique la informacion ingresada",
            "E15"),
    DUPLICATE_TEAM_NAME("El nombre del equipo ya está registrado.",
            "Por favor, elige otro nombre e intenta nuevamente",
            "E16"),
    USER_WITHOUT_PROFILE("El usuario aun no a registrado el perfil.",
            "Por favor, complete la informacion de su perfil",
            "E17"),
    USER_OWNER("No puedes salir del equipo porque eres el Administrador.",
            "Asigna otro Adminsitrador antes de salir",
            "E18"),
    USER_WITHOUT_TEAM("Aún no estás registrado en ningún equipo.",
            "Crea o únete a un equipo para comenzar",
            "E19"),
    INVALID_OLD_PASSWORD("La contraseña actual no concuerda",
            "Verifique la informacion ingresada",
            "E20"),
    DUPLICATE_ESTABLISHMENT_NAME("El nombre del establecimiento ya se encuentra creado",
            "Verifique la informacion ingresada",
            "E21"),
    GENERIC_DUPLICATE("%s ya está registrado.",
            "Por favor, elige otra opcion e intenta nuevamente",
            "E22"),
    DUPLICATE_BLOCKADE("Ya existe un bloqueo para la cancha %s para el dia %s entre los horarios %s y %s.",
            "Por favor, edite el bloqueo",
            "E23");


    private final String message;
    private final String recommendation;
    private final String code;

    public String getFormattedMessage(Object... args) {
        try {
            return String.format(message, args);
        } catch (MissingFormatArgumentException e) {
            return message; // Devuelve el mensaje sin formato si falta algún argumento
        }
    }

}
