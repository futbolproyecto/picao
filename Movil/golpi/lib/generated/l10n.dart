// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `¿No tienes una cuenta?`
  String get preguntaRegistrar {
    return Intl.message(
      '¿No tienes una cuenta?',
      name: 'preguntaRegistrar',
      desc: '',
      args: [],
    );
  }

  /// `Registrar`
  String get registrar {
    return Intl.message(
      'Registrar',
      name: 'registrar',
      desc: '',
      args: [],
    );
  }

  /// `Bienvenido`
  String get bienvenido {
    return Intl.message(
      'Bienvenido',
      name: 'bienvenido',
      desc: '',
      args: [],
    );
  }

  /// `Ingresa tus datos de sesión`
  String get ingresaDatosSesion {
    return Intl.message(
      'Ingresa tus datos de sesión',
      name: 'ingresaDatosSesion',
      desc: '',
      args: [],
    );
  }

  /// `Correo o celular`
  String get correoCelular {
    return Intl.message(
      'Correo o celular',
      name: 'correoCelular',
      desc: '',
      args: [],
    );
  }

  /// `Clave`
  String get clave {
    return Intl.message(
      'Clave',
      name: 'clave',
      desc: '',
      args: [],
    );
  }

  /// `Validar`
  String get validar {
    return Intl.message(
      'Validar',
      name: 'validar',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar`
  String get cerrar {
    return Intl.message(
      'Cerrar',
      name: 'cerrar',
      desc: '',
      args: [],
    );
  }

  /// `La información se registró de manera exitosa`
  String get exitoRegistrar {
    return Intl.message(
      'La información se registró de manera exitosa',
      name: 'exitoRegistrar',
      desc: '',
      args: [],
    );
  }

  /// `La clave se actualizó correctamente`
  String get exitoActualizarClave {
    return Intl.message(
      'La clave se actualizó correctamente',
      name: 'exitoActualizarClave',
      desc: '',
      args: [],
    );
  }

  /// `Ingresar`
  String get ingresar {
    return Intl.message(
      'Ingresar',
      name: 'ingresar',
      desc: '',
      args: [],
    );
  }

  /// `¿Olvidaste tu contraseña?`
  String get preguntaOlvidoClave {
    return Intl.message(
      '¿Olvidaste tu contraseña?',
      name: 'preguntaOlvidoClave',
      desc: '',
      args: [],
    );
  }

  /// `¿Ya tienes una cuenta?`
  String get preguntaTienesCuenta {
    return Intl.message(
      '¿Ya tienes una cuenta?',
      name: 'preguntaTienesCuenta',
      desc: '',
      args: [],
    );
  }

  /// `Registro de información`
  String get registroInformacion {
    return Intl.message(
      'Registro de información',
      name: 'registroInformacion',
      desc: '',
      args: [],
    );
  }

  /// `Nombres`
  String get nombres {
    return Intl.message(
      'Nombres',
      name: 'nombres',
      desc: '',
      args: [],
    );
  }

  /// `Apellidos`
  String get apellidos {
    return Intl.message(
      'Apellidos',
      name: 'apellidos',
      desc: '',
      args: [],
    );
  }

  /// `Correo`
  String get correo {
    return Intl.message(
      'Correo',
      name: 'correo',
      desc: '',
      args: [],
    );
  }

  /// `Celular`
  String get celular {
    return Intl.message(
      'Celular',
      name: 'celular',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de nacimiento`
  String get fechaNacimiento {
    return Intl.message(
      'Fecha de nacimiento',
      name: 'fechaNacimiento',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar clave`
  String get confirmarClave {
    return Intl.message(
      'Confirmar clave',
      name: 'confirmarClave',
      desc: '',
      args: [],
    );
  }

  /// `La contraseña no coincide`
  String get claveNoCoincide {
    return Intl.message(
      'La contraseña no coincide',
      name: 'claveNoCoincide',
      desc: '',
      args: [],
    );
  }

  /// `Caracteres especiales`
  String get caracteresEspeciales {
    return Intl.message(
      'Caracteres especiales',
      name: 'caracteresEspeciales',
      desc: '',
      args: [],
    );
  }

  /// `{numero} caracteres`
  String nCaracteres(Object numero) {
    return Intl.message(
      '$numero caracteres',
      name: 'nCaracteres',
      desc: '',
      args: [numero],
    );
  }

  /// `Mayúscula`
  String get mayuscula {
    return Intl.message(
      'Mayúscula',
      name: 'mayuscula',
      desc: '',
      args: [],
    );
  }

  /// `Minúscula`
  String get minuscula {
    return Intl.message(
      'Minúscula',
      name: 'minuscula',
      desc: '',
      args: [],
    );
  }

  /// `Números`
  String get numeros {
    return Intl.message(
      'Números',
      name: 'numeros',
      desc: '',
      args: [],
    );
  }

  /// `Acepto los `
  String get inicioMensajeTerminos {
    return Intl.message(
      'Acepto los ',
      name: 'inicioMensajeTerminos',
      desc: '',
      args: [],
    );
  }

  /// `Términos`
  String get terminos {
    return Intl.message(
      'Términos',
      name: 'terminos',
      desc: '',
      args: [],
    );
  }

  /// `y`
  String get y {
    return Intl.message(
      'y',
      name: 'y',
      desc: '',
      args: [],
    );
  }

  /// `Condiciones`
  String get condiciones {
    return Intl.message(
      'Condiciones',
      name: 'condiciones',
      desc: '',
      args: [],
    );
  }

  /// `Debes aceptar los términos y condiciones`
  String get aceptarTerminos {
    return Intl.message(
      'Debes aceptar los términos y condiciones',
      name: 'aceptarTerminos',
      desc: '',
      args: [],
    );
  }

  /// `¿Deseas iniciar sesión?`
  String get preguntaIniciarSesion {
    return Intl.message(
      '¿Deseas iniciar sesión?',
      name: 'preguntaIniciarSesion',
      desc: '',
      args: [],
    );
  }

  /// `Restablecer contraseña`
  String get restablecerClave {
    return Intl.message(
      'Restablecer contraseña',
      name: 'restablecerClave',
      desc: '',
      args: [],
    );
  }

  /// `Por favor, introduce el correo electrónico asociado a tu cuenta para recuperar tu contraseña.`
  String get correoAsociadoCuenta {
    return Intl.message(
      'Por favor, introduce el correo electrónico asociado a tu cuenta para recuperar tu contraseña.',
      name: 'correoAsociadoCuenta',
      desc: '',
      args: [],
    );
  }

  /// `Perfil`
  String get perfil {
    return Intl.message(
      'Perfil',
      name: 'perfil',
      desc: '',
      args: [],
    );
  }

  /// `Mi perfil`
  String get miPerfil {
    return Intl.message(
      'Mi perfil',
      name: 'miPerfil',
      desc: '',
      args: [],
    );
  }

  /// `Guardar`
  String get guardar {
    return Intl.message(
      'Guardar',
      name: 'guardar',
      desc: '',
      args: [],
    );
  }

  /// `Zona`
  String get zona {
    return Intl.message(
      'Zona',
      name: 'zona',
      desc: '',
      args: [],
    );
  }

  /// `Ciudad`
  String get ciudad {
    return Intl.message(
      'Ciudad',
      name: 'ciudad',
      desc: '',
      args: [],
    );
  }

  /// `Pie dominante`
  String get pieDominante {
    return Intl.message(
      'Pie dominante',
      name: 'pieDominante',
      desc: '',
      args: [],
    );
  }

  /// `Estatura (CM)`
  String get estaturaCm {
    return Intl.message(
      'Estatura (CM)',
      name: 'estaturaCm',
      desc: '',
      args: [],
    );
  }

  /// `Peso (KG)`
  String get pesoKg {
    return Intl.message(
      'Peso (KG)',
      name: 'pesoKg',
      desc: '',
      args: [],
    );
  }

  /// `Posición`
  String get posicion {
    return Intl.message(
      'Posición',
      name: 'posicion',
      desc: '',
      args: [],
    );
  }

  /// `Alias`
  String get alias {
    return Intl.message(
      'Alias',
      name: 'alias',
      desc: '',
      args: [],
    );
  }

  /// `Agregar jugador`
  String get agregarJugador {
    return Intl.message(
      'Agregar jugador',
      name: 'agregarJugador',
      desc: '',
      args: [],
    );
  }

  /// `Cancelar`
  String get cancelar {
    return Intl.message(
      'Cancelar',
      name: 'cancelar',
      desc: '',
      args: [],
    );
  }

  /// `Buscar`
  String get buscar {
    return Intl.message(
      'Buscar',
      name: 'buscar',
      desc: '',
      args: [],
    );
  }

  /// `Invitar jugador`
  String get invitarJugador {
    return Intl.message(
      'Invitar jugador',
      name: 'invitarJugador',
      desc: '',
      args: [],
    );
  }

  /// `{jugador} ha sido agregado exitosamente al equipo`
  String jugadorAgregadoEquipo(Object jugador) {
    return Intl.message(
      '$jugador ha sido agregado exitosamente al equipo',
      name: 'jugadorAgregadoEquipo',
      desc: '',
      args: [jugador],
    );
  }

  /// `Hola, quiero invitarte a que descargues Golpi, una app para organizar partidos de fútbol. Descarga aquí: https://golpi.com`
  String get invitacionDescargaGolpi {
    return Intl.message(
      'Hola, quiero invitarte a que descargues Golpi, una app para organizar partidos de fútbol. Descarga aquí: https://golpi.com',
      name: 'invitacionDescargaGolpi',
      desc: '',
      args: [],
    );
  }

  /// `¿Está seguro que desea salir del equipo {equipo} Perderás acceso a sus actividades y notificaciones?`
  String confirmacionSalirEquipo(Object equipo) {
    return Intl.message(
      '¿Está seguro que desea salir del equipo $equipo Perderás acceso a sus actividades y notificaciones?',
      name: 'confirmacionSalirEquipo',
      desc: '',
      args: [equipo],
    );
  }

  /// `Salir`
  String get salir {
    return Intl.message(
      'Salir',
      name: 'salir',
      desc: '',
      args: [],
    );
  }

  /// `Has salido exitosamente del equipo {equipo}`
  String exitoSalirEquipo(Object equipo) {
    return Intl.message(
      'Has salido exitosamente del equipo $equipo',
      name: 'exitoSalirEquipo',
      desc: '',
      args: [equipo],
    );
  }

  /// `Rol`
  String get rol {
    return Intl.message(
      'Rol',
      name: 'rol',
      desc: '',
      args: [],
    );
  }

  /// `Cantidad jugadores`
  String get cantidadJugadores {
    return Intl.message(
      'Cantidad jugadores',
      name: 'cantidadJugadores',
      desc: '',
      args: [],
    );
  }

  /// `Equipo`
  String get equipo {
    return Intl.message(
      'Equipo',
      name: 'equipo',
      desc: '',
      args: [],
    );
  }

  /// `Registrar equipo`
  String get registrarEquipo {
    return Intl.message(
      'Registrar equipo',
      name: 'registrarEquipo',
      desc: '',
      args: [],
    );
  }

  /// `Nombre del equipo`
  String get nombreEquipo {
    return Intl.message(
      'Nombre del equipo',
      name: 'nombreEquipo',
      desc: '',
      args: [],
    );
  }

  /// `Representante`
  String get representante {
    return Intl.message(
      'Representante',
      name: 'representante',
      desc: '',
      args: [],
    );
  }

  /// `Número de contacto`
  String get numeroContacto {
    return Intl.message(
      'Número de contacto',
      name: 'numeroContacto',
      desc: '',
      args: [],
    );
  }

  /// `Administrar equipo`
  String get administrarEquipo {
    return Intl.message(
      'Administrar equipo',
      name: 'administrarEquipo',
      desc: '',
      args: [],
    );
  }

  /// `Cerrar sesión`
  String get cerrarSesion {
    return Intl.message(
      'Cerrar sesión',
      name: 'cerrarSesion',
      desc: '',
      args: [],
    );
  }

  /// `Ajustes`
  String get ajustes {
    return Intl.message(
      'Ajustes',
      name: 'ajustes',
      desc: '',
      args: [],
    );
  }

  /// `Inicio`
  String get inicio {
    return Intl.message(
      'Inicio',
      name: 'inicio',
      desc: '',
      args: [],
    );
  }

  /// `Equipos`
  String get equipos {
    return Intl.message(
      'Equipos',
      name: 'equipos',
      desc: '',
      args: [],
    );
  }

  /// `Encuentros`
  String get encuentros {
    return Intl.message(
      'Encuentros',
      name: 'encuentros',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message(
      'Chats',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `Fecha de reserva`
  String get fechaReserva {
    return Intl.message(
      'Fecha de reserva',
      name: 'fechaReserva',
      desc: '',
      args: [],
    );
  }

  /// `Hora inicio`
  String get horaInicio {
    return Intl.message(
      'Hora inicio',
      name: 'horaInicio',
      desc: '',
      args: [],
    );
  }

  /// `Hora fin`
  String get horaFin {
    return Intl.message(
      'Hora fin',
      name: 'horaFin',
      desc: '',
      args: [],
    );
  }

  /// `Ubicación`
  String get ubicacion {
    return Intl.message(
      'Ubicación',
      name: 'ubicacion',
      desc: '',
      args: [],
    );
  }

  /// `Establecimiento`
  String get establecimiento {
    return Intl.message(
      'Establecimiento',
      name: 'establecimiento',
      desc: '',
      args: [],
    );
  }

  /// `Buscar establecimiento`
  String get buscarEstablecimiento {
    return Intl.message(
      'Buscar establecimiento',
      name: 'buscarEstablecimiento',
      desc: '',
      args: [],
    );
  }

  /// `Dirección`
  String get direccion {
    return Intl.message(
      'Dirección',
      name: 'direccion',
      desc: '',
      args: [],
    );
  }

  /// `Fecha`
  String get fecha {
    return Intl.message(
      'Fecha',
      name: 'fecha',
      desc: '',
      args: [],
    );
  }

  /// `Dia`
  String get dia {
    return Intl.message(
      'Dia',
      name: 'dia',
      desc: '',
      args: [],
    );
  }

  /// `Hora`
  String get hora {
    return Intl.message(
      'Hora',
      name: 'hora',
      desc: '',
      args: [],
    );
  }

  /// `Tarifa`
  String get tarifa {
    return Intl.message(
      'Tarifa',
      name: 'tarifa',
      desc: '',
      args: [],
    );
  }

  /// `Cancha`
  String get cancha {
    return Intl.message(
      'Cancha',
      name: 'cancha',
      desc: '',
      args: [],
    );
  }

  /// `Filtros`
  String get filtros {
    return Intl.message(
      'Filtros',
      name: 'filtros',
      desc: '',
      args: [],
    );
  }

  /// `Confirmar`
  String get confirmar {
    return Intl.message(
      'Confirmar',
      name: 'confirmar',
      desc: '',
      args: [],
    );
  }

  /// `¿Deseas confirmar la reserva en {establecimiento} {cancha}, para la fecha {fecha} {horario}`
  String confirmacionReserva(
      Object establecimiento, Object cancha, Object fecha, Object horario) {
    return Intl.message(
      '¿Deseas confirmar la reserva en $establecimiento $cancha, para la fecha $fecha $horario',
      name: 'confirmacionReserva',
      desc: '',
      args: [establecimiento, cancha, fecha, horario],
    );
  }

  /// `Solo puedes seleccionar canchas del mismo establecimiento.`
  String get seleccionCanchaVacia {
    return Intl.message(
      'Solo puedes seleccionar canchas del mismo establecimiento.',
      name: 'seleccionCanchaVacia',
      desc: '',
      args: [],
    );
  }

  /// `Solo puedes seleccionar canchas del mismo establecimiento.`
  String get establecimientosDistintos {
    return Intl.message(
      'Solo puedes seleccionar canchas del mismo establecimiento.',
      name: 'establecimientosDistintos',
      desc: '',
      args: [],
    );
  }

  /// `Solo puedes seleccionar horarios de la misma fecha.`
  String get fechasDistintas {
    return Intl.message(
      'Solo puedes seleccionar horarios de la misma fecha.',
      name: 'fechasDistintas',
      desc: '',
      args: [],
    );
  }

  /// `Solo puedes seleccionar horarios de la misma cancha`
  String get canchasDistintas {
    return Intl.message(
      'Solo puedes seleccionar horarios de la misma cancha',
      name: 'canchasDistintas',
      desc: '',
      args: [],
    );
  }

  /// `Solo puedes seleccionar horas consecutivas.`
  String get harariosDistintos {
    return Intl.message(
      'Solo puedes seleccionar horas consecutivas.',
      name: 'harariosDistintos',
      desc: '',
      args: [],
    );
  }

  /// `a la(s) {hora}`
  String mensajeHorario1(Object hora) {
    return Intl.message(
      'a la(s) $hora',
      name: 'mensajeHorario1',
      desc: '',
      args: [hora],
    );
  }

  /// `desde la(s) {hora1} hasta la(s) {hora2}`
  String mensajeHorario2(Object hora1, Object hora2) {
    return Intl.message(
      'desde la(s) $hora1 hasta la(s) $hora2',
      name: 'mensajeHorario2',
      desc: '',
      args: [hora1, hora2],
    );
  }

  /// `Reservar`
  String get reservar {
    return Intl.message(
      'Reservar',
      name: 'reservar',
      desc: '',
      args: [],
    );
  }

  /// `Tu reserva ha sido guardada. Puedes verla en la sección Mis Encuentros`
  String get exitoReserva {
    return Intl.message(
      'Tu reserva ha sido guardada. Puedes verla en la sección Mis Encuentros',
      name: 'exitoReserva',
      desc: '',
      args: [],
    );
  }

  /// `--------------------------------------------`
  String get mensajesErrorFormularios {
    return Intl.message(
      '--------------------------------------------',
      name: 'mensajesErrorFormularios',
      desc: '',
      args: [],
    );
  }

  /// `Campo requerido`
  String get campoRequerido {
    return Intl.message(
      'Campo requerido',
      name: 'campoRequerido',
      desc: '',
      args: [],
    );
  }

  /// `Máximo {numero} caracteres`
  String longitudMaximo(Object numero) {
    return Intl.message(
      'Máximo $numero caracteres',
      name: 'longitudMaximo',
      desc: '',
      args: [numero],
    );
  }

  /// `Mínimo {numero} caracteres`
  String longitudMinimo(Object numero) {
    return Intl.message(
      'Mínimo $numero caracteres',
      name: 'longitudMinimo',
      desc: '',
      args: [numero],
    );
  }

  /// `Formato de correo incorrecto`
  String get formatoCorreoIncorrecto {
    return Intl.message(
      'Formato de correo incorrecto',
      name: 'formatoCorreoIncorrecto',
      desc: '',
      args: [],
    );
  }

  /// `Solo se permiten numeros`
  String get soloNumeros {
    return Intl.message(
      'Solo se permiten numeros',
      name: 'soloNumeros',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'es', countryCode: 'CO'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
