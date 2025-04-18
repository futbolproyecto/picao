import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/theme/theme.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:golpi/core/bindings/initial_binding.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors
        .transparent, // 🔹 Hace que el fondo de la barra de estado sea transparente
    statusBarIconBrightness: Brightness.dark, // 🔹 Iconos oscuros por defecto
    statusBarBrightness: Brightness.light, // 🔹 Para iOS
  ));
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final MaterialTheme materialTheme = MaterialTheme(const TextTheme());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          mediaQueryData:
              MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          maxWidth: 1200,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          backgroundColor: Theme.of(context).colorScheme.primary),
      title: 'Golpi',
      initialBinding: InitialBinding(),
      initialRoute: AppPages.splash,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: ThemeMode.light,
      locale: Locale('es'),
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
