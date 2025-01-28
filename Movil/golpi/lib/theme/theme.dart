import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278218039),
      surfaceTint: Color(4278218039),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4283629462),
      onPrimaryContainer: Color(4278219579),
      secondary: Color(4283766141),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285411990),
      onSecondaryContainer: Color(4292914943),
      tertiary: Color(4284309087),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4291085508),
      onTertiaryContainer: Color(4283453777),
      error: Color(4290386458),
      onError: Color(4294967295),
      errorContainer: Color(4294957782),
      onErrorContainer: Color(4287823882),
      surface: Color(4294507253),
      onSurface: Color(4279835674),
      onSurfaceVariant: Color(4282533954),
      outline: Color(4285692273),
      outlineVariant: Color(4290955456),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217326),
      inversePrimary: Color(4280869757),
      primaryFixed: Color(4284481434),
      onPrimaryFixed: Color(4278198541),
      primaryFixedDim: Color(4280869757),
      onPrimaryFixedVariant: Color(4278211112),
      secondaryFixed: Color(4294236927),
      onSecondaryFixed: Color(4281270348),
      secondaryFixedDim: Color(4293178879),
      onSecondaryFixedVariant: Color(4284819597),
      tertiaryFixed: Color(4293124834),
      onTertiaryFixed: Color(4279901212),
      tertiaryFixedDim: Color(4291217094),
      onTertiaryFixedVariant: Color(4282795847),
      surfaceDim: Color(4292467670),
      surfaceBright: Color(4294507253),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112496),
      surfaceContainer: Color(4293783274),
      surfaceContainerHigh: Color(4293388772),
      surfaceContainerHighest: Color(4292994015),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278206238),
      surfaceTint: Color(4278218039),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278222401),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4283634299),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285411990),
      onSecondaryContainer: Color(4294633727),
      tertiary: Color(4281677367),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4285295981),
      onTertiaryContainer: Color(4294967295),
      error: Color(4285792262),
      onError: Color(4294967295),
      errorContainer: Color(4291767335),
      onErrorContainer: Color(4294967295),
      surface: Color(4294507253),
      onSurface: Color(4279177744),
      onSurfaceVariant: Color(4281415730),
      outline: Color(4283257933),
      outlineVariant: Color(4285034343),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217326),
      inversePrimary: Color(4280869757),
      primaryFixed: Color(4278222401),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278215217),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4287582903),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4285806748),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4285295981),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4283716949),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4291151811),
      surfaceBright: Color(4294507253),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294112496),
      surfaceContainer: Color(4293388772),
      surfaceContainerHigh: Color(4292599257),
      surfaceContainerHighest: Color(4291875534),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(4278203415),
      surfaceTint: Color(4278218039),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4278211882),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282843248),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4285016976),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4281019437),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4282927434),
      onTertiaryContainer: Color(4294967295),
      error: Color(4284481540),
      onError: Color(4294967295),
      errorContainer: Color(4288151562),
      onErrorContainer: Color(4294967295),
      surface: Color(4294507253),
      onSurface: Color(4278190080),
      onSurfaceVariant: Color(4278190080),
      outline: Color(4280757800),
      outlineVariant: Color(4282665796),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281217326),
      inversePrimary: Color(4280869757),
      primaryFixed: Color(4278211882),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278205211),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4285016976),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4283370615),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4282927434),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4281414451),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4290230709),
      surfaceBright: Color(4294507253),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4293980653),
      surfaceContainer: Color(4292994015),
      surfaceContainerHigh: Color(4292072913),
      surfaceContainerHighest: Color(4291151811),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294770680),
      surfaceTint: Color(4280869757),
      onPrimary: Color(4278204698),
      primaryContainer: Color(4283629462),
      onPrimaryContainer: Color(4278219579),
      secondary: Color(4293178879),
      onSecondary: Color(4283172725),
      secondaryContainer: Color(4285411990),
      onSecondaryContainer: Color(4292914943),
      tertiary: Color(4292927712),
      onTertiary: Color(4281282865),
      tertiaryContainer: Color(4291085508),
      onTertiaryContainer: Color(4283453777),
      error: Color(4294948011),
      onError: Color(4285071365),
      errorContainer: Color(4287823882),
      onErrorContainer: Color(4294957782),
      surface: Color(4279309330),
      onSurface: Color(4292994015),
      onSurfaceVariant: Color(4290955456),
      outline: Color(4287402891),
      outlineVariant: Color(4282533954),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292994015),
      inversePrimary: Color(4278218039),
      primaryFixed: Color(4284481434),
      onPrimaryFixed: Color(4278198541),
      primaryFixedDim: Color(4280869757),
      onPrimaryFixedVariant: Color(4278211112),
      secondaryFixed: Color(4294236927),
      onSecondaryFixed: Color(4281270348),
      secondaryFixedDim: Color(4293178879),
      onSecondaryFixedVariant: Color(4284819597),
      tertiaryFixed: Color(4293124834),
      onTertiaryFixed: Color(4279901212),
      tertiaryFixedDim: Color(4291217094),
      onTertiaryFixedVariant: Color(4282795847),
      surfaceDim: Color(4279309330),
      surfaceBright: Color(4281809463),
      surfaceContainerLowest: Color(4278980365),
      surfaceContainerLow: Color(4279835674),
      surfaceContainer: Color(4280098846),
      surfaceContainerHigh: Color(4280822568),
      surfaceContainerHighest: Color(4281480755),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294770680),
      surfaceTint: Color(4280869757),
      onPrimary: Color(4278204698),
      primaryContainer: Color(4283629462),
      onPrimaryContainer: Color(4278211369),
      secondary: Color(4293972735),
      onSecondary: Color(4282253410),
      secondaryContainer: Color(4290082526),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4292927712),
      onTertiary: Color(4280756521),
      tertiaryContainer: Color(4291085508),
      onTertiaryContainer: Color(4281546037),
      error: Color(4294955724),
      onError: Color(4283695107),
      errorContainer: Color(4294923337),
      onErrorContainer: Color(4278190080),
      surface: Color(4279309330),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4292402901),
      outline: Color(4289574059),
      outlineVariant: Color(4287337098),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292994015),
      inversePrimary: Color(4278211625),
      primaryFixed: Color(4284481434),
      onPrimaryFixed: Color(4278195462),
      primaryFixedDim: Color(4280869757),
      onPrimaryFixedVariant: Color(4278206238),
      secondaryFixed: Color(4294236927),
      onSecondaryFixed: Color(4280287285),
      secondaryFixedDim: Color(4293178879),
      onSecondaryFixedVariant: Color(4283634299),
      tertiaryFixed: Color(4293124834),
      onTertiaryFixed: Color(4279243026),
      tertiaryFixedDim: Color(4291217094),
      onTertiaryFixedVariant: Color(4281677367),
      surfaceDim: Color(4279309330),
      surfaceBright: Color(4282533186),
      surfaceContainerLowest: Color(4278585350),
      surfaceContainerLow: Color(4279967260),
      surfaceContainer: Color(4280625446),
      surfaceContainerHigh: Color(4281348912),
      surfaceContainerHighest: Color(4282072635),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(4294770680),
      surfaceTint: Color(4280869757),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4283629462),
      onPrimaryContainer: Color(4278202645),
      secondary: Color(4294700031),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4292980991),
      onSecondaryContainer: Color(4279697448),
      tertiary: Color(4293980400),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4291085508),
      onTertiaryContainer: Color(4278980110),
      error: Color(4294962409),
      onError: Color(4278190080),
      errorContainer: Color(4294946468),
      onErrorContainer: Color(4280418305),
      surface: Color(4279309330),
      onSurface: Color(4294967295),
      onSurfaceVariant: Color(4294967295),
      outline: Color(4293653224),
      outlineVariant: Color(4290692284),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4292994015),
      inversePrimary: Color(4278211625),
      primaryFixed: Color(4284481434),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4280869757),
      onPrimaryFixedVariant: Color(4278195462),
      secondaryFixed: Color(4294236927),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4293178879),
      onSecondaryFixedVariant: Color(4280287285),
      tertiaryFixed: Color(4293124834),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4291217094),
      onTertiaryFixedVariant: Color(4279243026),
      surfaceDim: Color(4279309330),
      surfaceBright: Color(4283322702),
      surfaceContainerLowest: Color(4278190080),
      surfaceContainerLow: Color(4280098846),
      surfaceContainer: Color(4281217326),
      surfaceContainerHigh: Color(4281941049),
      surfaceContainerHighest: Color(4282664772),
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
     scaffoldBackgroundColor: colorScheme.background,
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
