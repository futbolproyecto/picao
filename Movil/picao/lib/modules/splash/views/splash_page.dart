import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picao/modules/splash/controller/splash_controller.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});


  @override
  Widget build(BuildContext context) {
    Get.find<SplashController>();
    return const Scaffold(
      body: Center(
        child: Text('Splash'),
      ),
    );
  }
}
