export class Constant {
  //Cantidad minima Validators
  static CAMPO_MINIMO_CONTRASENA = 6;
  static CAMPO_MINIMO_2 = 2;
  static CAMPO_MINIMO_4 = 4;
  static CAMPO_MINIMO_7 = 7;
  static CAMPO_MINIMO_10 = 10;
  static CAMPO_MINIMO_11 = 11;

  //Cantidad maxima Validators
  static CAMPO_MAXIMO_50 = 50;
  static CAMPO_MAXIMO_CONTRASENA = 30;
  static CAMPO_MAXIMO_20 = 20;
  static CAMPO_MAXIMO_100 = 100;

  static PATTERN_NUMEROS = /^\d+$/;
  static PATTERN_CORREO =
    /^[a-z0-9+_-]+(?:\.[a-z0-9+_-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$/;
  static PATTERN_LETRAS_NUMEROS = /^[A-Za-z0-9]+$/;
  static PATTERN_CONTRASENA =
    /^(?=\D*\d)(?=[^a-z]*[a-z])(?=[^A-Z]*[A-Z])(?=[^!"#$%'()*+,\-./:;<=>?@\[\]\\^_`{|}~]*[!"#$%'()*+,\-./:;<=>?@\[\]\\^_`{|}~]).{8,30}$/;

  //  Form field errors
  static ERROR_CAMPO_REQUERIDO = 'Campo requerido';
  static ERROR_CAMPO_ESTABLECIMIENTO = 'Debes seleccionar un establecimiento.';
  static ERROR_CAMPO_FECHA_INICIO = 'Debes seleccionar una fecha de inicio.';
  static ERROR_CAMPO_FECHA_FIN = 'Debes seleccionar una fecha de fin.';
  static ERROR_CAMPO_HORA_INICIO = 'Debes seleccionar una hora de inicio.';
  static ERROR_CAMPO_HORA_FIN = 'Debes seleccionar una hora de fin.';
  static ERROR_CAMPO_DIA = 'Debes seleccionar al menos un día.';
  static ERROR_CAMPO_CANCHA = 'Debes seleccionar al menos una cancha';
  static ERROR_FORM_INCOMPLETO =
    'Todos los campos deben estar correctamente diligenciados.';
  static ERROR_CAMPO_REQUERIDO_CORREO = 'Ingrese su correo electrónico';
  static ERROR_CAMPO_REQUERIDO_CONTRASENA = 'Ingrese su contraseña';
  static ERROR_CAMPO_MINIMO_2 = 'Este campo es de mínimo 2 caracteres';
  static ERROR_CAMPO_MINIMO_10 = 'Este campo es de mínimo 10 caracteres';
  static ERROR_CAMPO_MINIMO_11 = 'Este campo es de mínimo 11 caracteres';
  static ERROR_CAMPO_MAXIMO_50 = 'Este campo es de máximo 50 caracteres';
  static ERROR_CAMPO_MINIMO_CONTRASENA = 'Este campo es de mínimo 6 caracteres';
  static ERROR_CAMPO_MAXIMO_CONTRASENA =
    'Este campo es de máximo 30 caracteres';
  static ERROR_CAMPO_MINIMO_4 = 'Este campo es de mínimo 4 caracteres';
  static ERROR_CAMPO_REQUERIDO_NOMBRE = 'Ingrese un nombre';
  static ERROR_CAMPO_REQUERIDO_CELULAR = 'Ingrese un numero celular';
  static ERROR_CAMPO_MINIMO_7 = 'Este campo es de mínimo 7 caracteres';
  static ERROR_CAMPO_MAXIMO_20 = 'Este campo es de máximo 20 caracteres';
  static ERROR_CAMPO_SOLO_NUMEROS = 'Solo se permiten números';
  static ERROR_CAMPO_SOLO_NUMEROS_LETRAS = 'Solo se permiten números y letras';
  static ERROR_CAMPO_EMAIL_INVALIDO = 'El email es inválido';
  static ERROR_CAMPO_NO_ESPACIOS = 'No se permiten espacios.';
  static ERROR_CAMPO_CONTRASENA_NO_CONCIDEN =
    'La contraseña nueva y la confirmación de contraseña no coinciden.';
}
