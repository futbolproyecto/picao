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

  /// `La información se registro de manera exitosa`
  String get exitoRegistrar {
    return Intl.message(
      'La información se registro de manera exitosa',
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

  /// `Fecha nacimiento`
  String get fechaNacimiento {
    return Intl.message(
      'Fecha nacimiento',
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

  /// `Mayuscula`
  String get mayuscula {
    return Intl.message(
      'Mayuscula',
      name: 'mayuscula',
      desc: '',
      args: [],
    );
  }

  /// `Minuscula`
  String get minuscula {
    return Intl.message(
      'Minuscula',
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

  /// `Terminos`
  String get terminos {
    return Intl.message(
      'Terminos',
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

  /// `¿Deseas iniciar sesion?`
  String get preguntaIniciarSesion {
    return Intl.message(
      '¿Deseas iniciar sesion?',
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

  /// `Máximo  {numero} caracteres`
  String longitudMaximo(Object numero) {
    return Intl.message(
      'Máximo  $numero caracteres',
      name: 'longitudMaximo',
      desc: '',
      args: [numero],
    );
  }

  /// `Minimo  {numero} caracteres`
  String longitudMinimo(Object numero) {
    return Intl.message(
      'Minimo  $numero caracteres',
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
