import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006d37),
      surfaceTint: Color(0xff006d37),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff52ff96),
      onPrimaryContainer: Color(0xff00733b),
      secondary: Color(0xff55157d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6e3296),
      onSecondaryContainer: Color(0xffe0aeff),
      tertiary: Color(0xff5d5e5f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffc4c4c4),
      onTertiaryContainer: Color(0xff505151),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff8faf5),
      onSurface: Color(0xff191c1a),
      onSurfaceVariant: Color(0xff424842),
      outline: Color(0xff727971),
      outlineVariant: Color(0xffc2c8c0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e312e),
      inversePrimary: Color(0xff28e37d),
      primaryFixed: Color(0xff5fff9a),
      onPrimaryFixed: Color(0xff00210d),
      primaryFixedDim: Color(0xff28e37d),
      onPrimaryFixedVariant: Color(0xff005228),
      secondaryFixed: Color(0xfff4daff),
      onSecondaryFixed: Color(0xff2f004c),
      secondaryFixedDim: Color(0xffe4b5ff),
      onSecondaryFixedVariant: Color(0xff65288d),
      tertiaryFixed: Color(0xffe3e2e2),
      onTertiaryFixed: Color(0xff1a1c1c),
      tertiaryFixedDim: Color(0xffc6c6c6),
      onTertiaryFixedVariant: Color(0xff464747),
      surfaceDim: Color(0xffd9dbd6),
      surfaceBright: Color(0xfff8faf5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f4f0),
      surfaceContainer: Color(0xffedeeea),
      surfaceContainerHigh: Color(0xffe7e9e4),
      surfaceContainerHighest: Color(0xffe1e3df),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003f1e),
      surfaceTint: Color(0xff006d37),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff007e41),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff53127b),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff6e3296),
      onSecondaryContainer: Color(0xfffae8ff),
      tertiary: Color(0xff353637),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff6c6d6d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8faf5),
      onSurface: Color(0xff0f1210),
      onSurfaceVariant: Color(0xff313832),
      outline: Color(0xff4d544d),
      outlineVariant: Color(0xff686f67),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e312e),
      inversePrimary: Color(0xff28e37d),
      primaryFixed: Color(0xff007e41),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006231),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff8f52b7),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff74389c),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff6c6d6d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff545555),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc5c7c3),
      surfaceBright: Color(0xfff8faf5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff2f4f0),
      surfaceContainer: Color(0xffe7e9e4),
      surfaceContainerHigh: Color(0xffdbddd9),
      surfaceContainerHighest: Color(0xffd0d2ce),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003417),
      surfaceTint: Color(0xff006d37),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff00552a),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff470070),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff682b90),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff2b2c2d),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff48494a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff8faf5),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff272e28),
      outlineVariant: Color(0xff444b44),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2e312e),
      inversePrimary: Color(0xff28e37d),
      primaryFixed: Color(0xff00552a),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003b1b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff682b90),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff4f0c77),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff48494a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff313333),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb7b9b5),
      surfaceBright: Color(0xfff8faf5),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f1ed),
      surfaceContainer: Color(0xffe1e3df),
      surfaceContainerHigh: Color(0xffd3d5d1),
      surfaceContainerHighest: Color(0xffc5c7c3),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffcfff8),
      surfaceTint: Color(0xff28e37d),
      onPrimary: Color(0xff00391a),
      primaryContainer: Color(0xff52ff96),
      onPrimaryContainer: Color(0xff00733b),
      secondary: Color(0xffe4b5ff),
      onSecondary: Color(0xff4c0775),
      secondaryContainer: Color(0xff6e3296),
      onSecondaryContainer: Color(0xffe0aeff),
      tertiary: Color(0xffe0e0e0),
      onTertiary: Color(0xff2f3131),
      tertiaryContainer: Color(0xffc4c4c4),
      onTertiaryContainer: Color(0xff505151),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff111412),
      onSurface: Color(0xffe1e3df),
      onSurfaceVariant: Color(0xffc2c8c0),
      outline: Color(0xff8c938b),
      outlineVariant: Color(0xff424842),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e3df),
      inversePrimary: Color(0xff006d37),
      primaryFixed: Color(0xff5fff9a),
      onPrimaryFixed: Color(0xff00210d),
      primaryFixedDim: Color(0xff28e37d),
      onPrimaryFixedVariant: Color(0xff005228),
      secondaryFixed: Color(0xfff4daff),
      onSecondaryFixed: Color(0xff2f004c),
      secondaryFixedDim: Color(0xffe4b5ff),
      onSecondaryFixedVariant: Color(0xff65288d),
      tertiaryFixed: Color(0xffe3e2e2),
      onTertiaryFixed: Color(0xff1a1c1c),
      tertiaryFixedDim: Color(0xffc6c6c6),
      onTertiaryFixedVariant: Color(0xff464747),
      surfaceDim: Color(0xff111412),
      surfaceBright: Color(0xff373a37),
      surfaceContainerLowest: Color(0xff0c0f0d),
      surfaceContainerLow: Color(0xff191c1a),
      surfaceContainer: Color(0xff1d201e),
      surfaceContainerHigh: Color(0xff282b28),
      surfaceContainerHighest: Color(0xff323633),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffcfff8),
      surfaceTint: Color(0xff28e37d),
      onPrimary: Color(0xff00391a),
      primaryContainer: Color(0xff52ff96),
      onPrimaryContainer: Color(0xff005329),
      secondary: Color(0xfff0d2ff),
      onSecondary: Color(0xff3e0062),
      secondaryContainer: Color(0xffb576de),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffe0e0e0),
      onTertiary: Color(0xff272929),
      tertiaryContainer: Color(0xffc4c4c4),
      onTertiaryContainer: Color(0xff333535),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff111412),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd8ded5),
      outline: Color(0xffadb4ab),
      outlineVariant: Color(0xff8b928a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e3df),
      inversePrimary: Color(0xff005429),
      primaryFixed: Color(0xff5fff9a),
      onPrimaryFixed: Color(0xff001506),
      primaryFixedDim: Color(0xff28e37d),
      onPrimaryFixedVariant: Color(0xff003f1e),
      secondaryFixed: Color(0xfff4daff),
      onSecondaryFixed: Color(0xff200035),
      secondaryFixedDim: Color(0xffe4b5ff),
      onSecondaryFixedVariant: Color(0xff53127b),
      tertiaryFixed: Color(0xffe3e2e2),
      onTertiaryFixed: Color(0xff101112),
      tertiaryFixedDim: Color(0xffc6c6c6),
      onTertiaryFixedVariant: Color(0xff353637),
      surfaceDim: Color(0xff111412),
      surfaceBright: Color(0xff424542),
      surfaceContainerLowest: Color(0xff060806),
      surfaceContainerLow: Color(0xff1b1e1c),
      surfaceContainer: Color(0xff252926),
      surfaceContainerHigh: Color(0xff303330),
      surfaceContainerHighest: Color(0xff3b3e3b),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffcfff8),
      surfaceTint: Color(0xff28e37d),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff52ff96),
      onPrimaryContainer: Color(0xff003115),
      secondary: Color(0xfffbebff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffe1b0ff),
      onSecondaryContainer: Color(0xff170028),
      tertiary: Color(0xfff0f0f0),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffc4c4c4),
      onTertiaryContainer: Color(0xff0c0e0e),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff111412),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffebf2e8),
      outlineVariant: Color(0xffbec4bc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe1e3df),
      inversePrimary: Color(0xff005429),
      primaryFixed: Color(0xff5fff9a),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff28e37d),
      onPrimaryFixedVariant: Color(0xff001506),
      secondaryFixed: Color(0xfff4daff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe4b5ff),
      onSecondaryFixedVariant: Color(0xff200035),
      tertiaryFixed: Color(0xffe3e2e2),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffc6c6c6),
      onTertiaryFixedVariant: Color(0xff101112),
      surfaceDim: Color(0xff111412),
      surfaceBright: Color(0xff4e514e),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1d201e),
      surfaceContainer: Color(0xff2e312e),
      surfaceContainerHigh: Color(0xff393c39),
      surfaceContainerHighest: Color(0xff444744),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
