// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a es_CO locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'es_CO';

  static String m0(establecimiento, cancha, fecha, horario) =>
      "¿Deseas confirmar la reserva en ${establecimiento} ${cancha}, para la fecha ${fecha} ${horario}";

  static String m1(equipo) =>
      "¿Está seguro que desea salir del equipo ${equipo} Perderás acceso a sus actividades y notificaciones?";

  static String m2(equipo) => "Has salido exitosamente del equipo ${equipo}";

  static String m3(jugador) =>
      "${jugador} ha sido agregado exitosamente al equipo";

  static String m4(numero) => "Máximo ${numero} caracteres";

  static String m5(numero) => "Mínimo ${numero} caracteres";

  static String m6(mobileNumber) =>
      "Se ha enviado un codigo OTP al numero ${mobileNumber}, ingresalo para continuar";

  static String m7(hora) => "a la(s) ${hora}";

  static String m8(hora1, hora2) => "desde la(s) ${hora1} hasta la(s) ${hora2}";

  static String m9(mobileNumber) =>
      "Hemos enviado un código OTP a tu WhatsApp (${mobileNumber}). Ingrésalo para confirmar la reserva.";

  static String m10(numero) => "${numero} caracteres";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "aceptarTerminos": MessageLookupByLibrary.simpleMessage(
            "Debes aceptar los términos y condiciones"),
        "administrarEquipo":
            MessageLookupByLibrary.simpleMessage("Administrar equipo"),
        "agregarJugador":
            MessageLookupByLibrary.simpleMessage("Agregar jugador"),
        "ajustes": MessageLookupByLibrary.simpleMessage("Ajustes"),
        "alias": MessageLookupByLibrary.simpleMessage("Alias"),
        "apellidos": MessageLookupByLibrary.simpleMessage("Apellidos"),
        "bienvenido": MessageLookupByLibrary.simpleMessage("Bienvenido"),
        "buscar": MessageLookupByLibrary.simpleMessage("Buscar"),
        "buscarEstablecimiento":
            MessageLookupByLibrary.simpleMessage("Buscar establecimiento"),
        "campoRequerido":
            MessageLookupByLibrary.simpleMessage("Campo requerido"),
        "cancelar": MessageLookupByLibrary.simpleMessage("Cancelar"),
        "cancha": MessageLookupByLibrary.simpleMessage("Cancha"),
        "canchasDistintas": MessageLookupByLibrary.simpleMessage(
            "Solo puedes seleccionar horarios de la misma cancha"),
        "cantidadJugadores":
            MessageLookupByLibrary.simpleMessage("Cantidad jugadores"),
        "caracteresEspeciales":
            MessageLookupByLibrary.simpleMessage("Caracteres especiales"),
        "celular": MessageLookupByLibrary.simpleMessage("Celular"),
        "cerrar": MessageLookupByLibrary.simpleMessage("Cerrar"),
        "cerrarSesion": MessageLookupByLibrary.simpleMessage("Cerrar sesión"),
        "chats": MessageLookupByLibrary.simpleMessage("Chats"),
        "ciudad": MessageLookupByLibrary.simpleMessage("Ciudad"),
        "clave": MessageLookupByLibrary.simpleMessage("Clave"),
        "claveNoCoincide":
            MessageLookupByLibrary.simpleMessage("La contraseña no coincide"),
        "condiciones": MessageLookupByLibrary.simpleMessage("Condiciones"),
        "confirmacionReserva": m0,
        "confirmacionSalirEquipo": m1,
        "confirmar": MessageLookupByLibrary.simpleMessage("Confirmar"),
        "confirmarClave":
            MessageLookupByLibrary.simpleMessage("Confirmar clave"),
        "correo": MessageLookupByLibrary.simpleMessage("Correo"),
        "correoAsociadoCuenta": MessageLookupByLibrary.simpleMessage(
            "Por favor, introduce el correo electrónico asociado a tu cuenta para recuperar tu contraseña."),
        "correoCelular":
            MessageLookupByLibrary.simpleMessage("Correo o celular"),
        "crearReserva": MessageLookupByLibrary.simpleMessage("Crear reserva"),
        "dia": MessageLookupByLibrary.simpleMessage("Dia"),
        "direccion": MessageLookupByLibrary.simpleMessage("Dirección"),
        "encuentros": MessageLookupByLibrary.simpleMessage("Encuentros"),
        "equipo": MessageLookupByLibrary.simpleMessage("Equipo"),
        "equipos": MessageLookupByLibrary.simpleMessage("Equipos"),
        "establecimiento":
            MessageLookupByLibrary.simpleMessage("Establecimiento"),
        "establecimientosDistintos": MessageLookupByLibrary.simpleMessage(
            "Solo puedes seleccionar canchas del mismo establecimiento."),
        "estaturaCm": MessageLookupByLibrary.simpleMessage("Estatura (CM)"),
        "exitoActualizarClave": MessageLookupByLibrary.simpleMessage(
            "La clave se actualizó correctamente"),
        "exitoRegistrar": MessageLookupByLibrary.simpleMessage(
            "La información se registró de manera exitosa"),
        "exitoReserva": MessageLookupByLibrary.simpleMessage(
            "Tu reserva ha sido guardada. Puedes verla en la sección Mis reservas"),
        "exitoSalirEquipo": m2,
        "fecha": MessageLookupByLibrary.simpleMessage("Fecha"),
        "fechaNacimiento":
            MessageLookupByLibrary.simpleMessage("Fecha de nacimiento"),
        "fechaReserva":
            MessageLookupByLibrary.simpleMessage("Fecha de reserva"),
        "fechasDistintas": MessageLookupByLibrary.simpleMessage(
            "Solo puedes seleccionar horarios de la misma fecha."),
        "filtros": MessageLookupByLibrary.simpleMessage("Filtros"),
        "formatoCorreoIncorrecto": MessageLookupByLibrary.simpleMessage(
            "Formato de correo incorrecto"),
        "guardar": MessageLookupByLibrary.simpleMessage("Guardar"),
        "harariosDistintos": MessageLookupByLibrary.simpleMessage(
            "Solo puedes seleccionar horas consecutivas."),
        "hora": MessageLookupByLibrary.simpleMessage("Hora"),
        "horaFin": MessageLookupByLibrary.simpleMessage("Hora fin"),
        "horaInicio": MessageLookupByLibrary.simpleMessage("Hora inicio"),
        "ingresaDatosSesion":
            MessageLookupByLibrary.simpleMessage("Ingresa tus datos de sesión"),
        "ingresar": MessageLookupByLibrary.simpleMessage("Ingresar"),
        "inicio": MessageLookupByLibrary.simpleMessage("Inicio"),
        "inicioMensajeTerminos":
            MessageLookupByLibrary.simpleMessage("Acepto los "),
        "invitacionDescargaGolpi": MessageLookupByLibrary.simpleMessage(
            "Hola, quiero invitarte a que descargues Golpi, una app para organizar partidos de fútbol. Descarga aquí: https://golpi.com"),
        "invitarJugador":
            MessageLookupByLibrary.simpleMessage("Invitar jugador"),
        "jugadorAgregadoEquipo": m3,
        "longitudMaximo": m4,
        "longitudMinimo": m5,
        "mayuscula": MessageLookupByLibrary.simpleMessage("Mayúscula"),
        "menesajeConfirmarOtp": m6,
        "mensajeHorario1": m7,
        "mensajeHorario2": m8,
        "mensajeOtpReserva": m9,
        "mensajesErrorFormularios": MessageLookupByLibrary.simpleMessage(
            "--------------------------------------------"),
        "miPerfil": MessageLookupByLibrary.simpleMessage("Mi perfil"),
        "minuscula": MessageLookupByLibrary.simpleMessage("Minúscula"),
        "misReservas": MessageLookupByLibrary.simpleMessage("Mis reservas"),
        "nCaracteres": m10,
        "nombreEquipo":
            MessageLookupByLibrary.simpleMessage("Nombre del equipo"),
        "nombres": MessageLookupByLibrary.simpleMessage("Nombres"),
        "numeroContacto":
            MessageLookupByLibrary.simpleMessage("Número de contacto"),
        "numeros": MessageLookupByLibrary.simpleMessage("Números"),
        "perfil": MessageLookupByLibrary.simpleMessage("Perfil"),
        "pesoKg": MessageLookupByLibrary.simpleMessage("Peso (KG)"),
        "pieDominante": MessageLookupByLibrary.simpleMessage("Pie dominante"),
        "posicion": MessageLookupByLibrary.simpleMessage("Posición"),
        "preguntaIniciarSesion":
            MessageLookupByLibrary.simpleMessage("¿Deseas iniciar sesión?"),
        "preguntaOlvidoClave":
            MessageLookupByLibrary.simpleMessage("¿Olvidaste tu contraseña?"),
        "preguntaRegistrar":
            MessageLookupByLibrary.simpleMessage("¿No tienes una cuenta?"),
        "preguntaTienesCuenta":
            MessageLookupByLibrary.simpleMessage("¿Ya tienes una cuenta?"),
        "registrar": MessageLookupByLibrary.simpleMessage("Registrar"),
        "registrarEquipo":
            MessageLookupByLibrary.simpleMessage("Registrar equipo"),
        "registroInformacion":
            MessageLookupByLibrary.simpleMessage("Registro de información"),
        "representante": MessageLookupByLibrary.simpleMessage("Representante"),
        "reservar": MessageLookupByLibrary.simpleMessage("Reservar"),
        "restablecerClave":
            MessageLookupByLibrary.simpleMessage("Restablecer contraseña"),
        "rol": MessageLookupByLibrary.simpleMessage("Rol"),
        "salir": MessageLookupByLibrary.simpleMessage("Salir"),
        "seleccionCanchaVacia": MessageLookupByLibrary.simpleMessage(
            "Solo puedes seleccionar canchas del mismo establecimiento."),
        "soloNumeros":
            MessageLookupByLibrary.simpleMessage("Solo se permiten numeros"),
        "tarifa": MessageLookupByLibrary.simpleMessage("Tarifa"),
        "terminos": MessageLookupByLibrary.simpleMessage("Términos"),
        "ubicacion": MessageLookupByLibrary.simpleMessage("Ubicación"),
        "validar": MessageLookupByLibrary.simpleMessage("Validar"),
        "y": MessageLookupByLibrary.simpleMessage("y"),
        "zona": MessageLookupByLibrary.simpleMessage("Zona")
      };
}
