import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff306a42),
      surfaceTint: Color(0xff306a42),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffb3f1bf),
      onPrimaryContainer: Color(0xff15512c),
      secondary: Color(0xff725187),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff4daff),
      onSecondaryContainer: Color(0xff59396e),
      tertiary: Color(0xff006874),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9eeffd),
      onTertiaryContainer: Color(0xff004f58),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfff6fbf3),
      onSurface: Color(0xff181d18),
      onSurfaceVariant: Color(0xff414941),
      outline: Color(0xff717971),
      outlineVariant: Color(0xffc1c9bf),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322d),
      inversePrimary: Color(0xff98d5a4),
      primaryFixed: Color(0xffb3f1bf),
      onPrimaryFixed: Color(0xff00210d),
      primaryFixedDim: Color(0xff98d5a4),
      onPrimaryFixedVariant: Color(0xff15512c),
      secondaryFixed: Color(0xfff4daff),
      onSecondaryFixed: Color(0xff2b0c3f),
      secondaryFixedDim: Color(0xffe0b8f6),
      onSecondaryFixedVariant: Color(0xff59396e),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff001f24),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff004f58),
      surfaceDim: Color(0xffd7dbd4),
      surfaceBright: Color(0xfff6fbf3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f5ed),
      surfaceContainer: Color(0xffebefe7),
      surfaceContainerHigh: Color(0xffe5eae2),
      surfaceContainerHighest: Color(0xffdfe4dc),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003f1e),
      surfaceTint: Color(0xff306a42),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff3f7950),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff48295c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff826097),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003c44),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff187884),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff6fbf3),
      onSurface: Color(0xff0d120e),
      onSurfaceVariant: Color(0xff313831),
      outline: Color(0xff4d544d),
      outlineVariant: Color(0xff676f67),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322d),
      inversePrimary: Color(0xff98d5a4),
      primaryFixed: Color(0xff3f7950),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff266039),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff826097),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff68477d),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff187884),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff005e68),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc3c8c0),
      surfaceBright: Color(0xfff6fbf3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff0f5ed),
      surfaceContainer: Color(0xffe5eae2),
      surfaceContainerHigh: Color(0xffdaded7),
      surfaceContainerHighest: Color(0xffced3cb),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff003417),
      surfaceTint: Color(0xff306a42),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff18542e),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3d1e51),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff5c3c71),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff003238),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff00515a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff6fbf3),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff272e27),
      outlineVariant: Color(0xff434b44),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2d322d),
      inversePrimary: Color(0xff98d5a4),
      primaryFixed: Color(0xff18542e),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003b1b),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff5c3c71),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff442558),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff00515a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00393f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffb5bab3),
      surfaceBright: Color(0xfff6fbf3),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeef2ea),
      surfaceContainer: Color(0xffdfe4dc),
      surfaceContainerHigh: Color(0xffd1d6ce),
      surfaceContainerHighest: Color(0xffc3c8c0),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff98d5a4),
      surfaceTint: Color(0xff98d5a4),
      onPrimary: Color(0xff00391a),
      primaryContainer: Color(0xff15512c),
      onPrimaryContainer: Color(0xffb3f1bf),
      secondary: Color(0xffe0b8f6),
      onSecondary: Color(0xff412356),
      secondaryContainer: Color(0xff59396e),
      onSecondaryContainer: Color(0xfff4daff),
      tertiary: Color(0xff82d3e0),
      onTertiary: Color(0xff00363d),
      tertiaryContainer: Color(0xff004f58),
      onTertiaryContainer: Color(0xff9eeffd),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff101510),
      onSurface: Color(0xffdfe4dc),
      onSurfaceVariant: Color(0xffc1c9bf),
      outline: Color(0xff8b938a),
      outlineVariant: Color(0xff414941),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4dc),
      inversePrimary: Color(0xff306a42),
      primaryFixed: Color(0xffb3f1bf),
      onPrimaryFixed: Color(0xff00210d),
      primaryFixedDim: Color(0xff98d5a4),
      onPrimaryFixedVariant: Color(0xff15512c),
      secondaryFixed: Color(0xfff4daff),
      onSecondaryFixed: Color(0xff2b0c3f),
      secondaryFixedDim: Color(0xffe0b8f6),
      onSecondaryFixedVariant: Color(0xff59396e),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff001f24),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff004f58),
      surfaceDim: Color(0xff101510),
      surfaceBright: Color(0xff353a35),
      surfaceContainerLowest: Color(0xff0b0f0b),
      surfaceContainerLow: Color(0xff181d18),
      surfaceContainer: Color(0xff1c211c),
      surfaceContainerHigh: Color(0xff262b26),
      surfaceContainerHighest: Color(0xff313631),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffadebb9),
      surfaceTint: Color(0xff98d5a4),
      onPrimary: Color(0xff002d13),
      primaryContainer: Color(0xff639d71),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xfff0d2ff),
      onSecondary: Color(0xff36174a),
      secondaryContainer: Color(0xffa783bd),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff98e9f7),
      onTertiary: Color(0xff002a30),
      tertiaryContainer: Color(0xff499ca9),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff101510),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffd7dfd4),
      outline: Color(0xffacb4ab),
      outlineVariant: Color(0xff8a9289),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4dc),
      inversePrimary: Color(0xff17522d),
      primaryFixed: Color(0xffb3f1bf),
      onPrimaryFixed: Color(0xff001506),
      primaryFixedDim: Color(0xff98d5a4),
      onPrimaryFixedVariant: Color(0xff003f1e),
      secondaryFixed: Color(0xfff4daff),
      onSecondaryFixed: Color(0xff200135),
      secondaryFixedDim: Color(0xffe0b8f6),
      onSecondaryFixedVariant: Color(0xff48295c),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff001417),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff003c44),
      surfaceDim: Color(0xff101510),
      surfaceBright: Color(0xff414640),
      surfaceContainerLowest: Color(0xff050805),
      surfaceContainerLow: Color(0xff1a1f1a),
      surfaceContainer: Color(0xff242924),
      surfaceContainerHigh: Color(0xff2f342f),
      surfaceContainerHighest: Color(0xff3a3f3a),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc0ffcc),
      surfaceTint: Color(0xff98d5a4),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff94d1a1),
      onPrimaryContainer: Color(0xff000f04),
      secondary: Color(0xfffbebff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffdcb4f2),
      onSecondaryContainer: Color(0xff170028),
      tertiary: Color(0xffcdf7ff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff7ecfdc),
      onTertiaryContainer: Color(0xff000e10),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff101510),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xffeaf2e8),
      outlineVariant: Color(0xffbdc5bb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdfe4dc),
      inversePrimary: Color(0xff17522d),
      primaryFixed: Color(0xffb3f1bf),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff98d5a4),
      onPrimaryFixedVariant: Color(0xff001506),
      secondaryFixed: Color(0xfff4daff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffe0b8f6),
      onSecondaryFixedVariant: Color(0xff200135),
      tertiaryFixed: Color(0xff9eeffd),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff82d3e0),
      onTertiaryFixedVariant: Color(0xff001417),
      surfaceDim: Color(0xff101510),
      surfaceBright: Color(0xff4c514c),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1c211c),
      surfaceContainer: Color(0xff2d322d),
      surfaceContainerHigh: Color(0xff383d37),
      surfaceContainerHighest: Color(0xff434843),
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

  List<ExtendedColor> get extendedColors => [];
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
