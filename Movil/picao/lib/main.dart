import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:picao/core/bindings/initial_binding.dart';
import 'package:picao/core/constants/constants.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Constants.primaryColor,
      statusBarIconBrightness: Brightness.dark,
    ));

    return GetMaterialApp(
      builder: (context, widget) => ResponsiveWrapper.builder(
            BouncingScrollWrapper.builder(context, widget!),
            mediaQueryData: MediaQuery.of(context)
                .copyWith(textScaler: TextScaler.noScaling),
            maxWidth: 1200,
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(450, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(800, name: TABLET),
              const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
              const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
              const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
            ],
          backgroundColor: Constants.primaryColor),
      title: 'Golpi',
      initialBinding: InitialBinding(),
      initialRoute: AppPages.splash,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Constants.primaryColor,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
