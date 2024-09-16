import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picao/core/bindings/initial_binding.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:picao/modules/user/views/login_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Golpi',
      home: LoginPage(),
      initialBinding: InitialBinding(),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
