import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:picao/core/bindings/initial_binding.dart';
import 'package:picao/core/constants/constants.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:picao/modules/login/views/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Constants.primaryColor, // Cambia el color de la barra de estado
      statusBarIconBrightness: Brightness
          .light, // Cambia el color de los iconos de la barra de estado a claro
    ));

    return GetMaterialApp(
      title: 'Golpi',
      home: LoginPage(),
      initialBinding: InitialBinding(),
      initialRoute: AppPages.login,
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
