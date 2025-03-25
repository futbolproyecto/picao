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
