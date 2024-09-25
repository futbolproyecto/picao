import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:picao/modules/user/controller/user_controller.dart';
import 'package:picao/modules/widgets/ui_text_field.dart';

class UserRegisterPage extends GetView<UserController> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  UserRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF04a57e);
    const Color secondaryColor = Color(0xFF19F489);

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              '¿Ya tienes una cuenta?',
              style: TextStyle(
                color: primaryColor,
                fontSize: 14,
              ),
            ),
            InkWell(
              onTap: () {
                Get.offNamed(AppPages.login);
              },
              child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: const Center(child: Text('Ingresar'))),
            )
          ],
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/img/golpilogo.png',
          width: 80,
        ),
        const Text('Golpi',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 20),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                spreadRadius: 0.5,
                blurRadius: 15,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(children: [
            const SizedBox(height: 20),
            const Text(
              'Registro de informacion',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            UiTextFiel().textField(
              labelText: 'Nombres',
              prefixIcon: Icons.person_2_outlined,
              colorPrefixIcon: primaryColor,
            ),
            const SizedBox(height: 20),
            UiTextFiel().textField(
              labelText: 'Apellidos',
              prefixIcon: Icons.person_2_outlined,
              colorPrefixIcon: primaryColor,
            ),
            const SizedBox(height: 20),
            UiTextFiel().textField(
              labelText: 'Correo',
              prefixIcon: Icons.email_outlined,
              colorPrefixIcon: primaryColor,
            ),
            const SizedBox(height: 20),
            UiTextFiel().textField(
              labelText: 'Clave',
              prefixIcon: Icons.lock_outline,
              colorPrefixIcon: primaryColor,
              obscureText: true,
              suffixIcon: Icons.remove_red_eye,
            ),
            const SizedBox(height: 20),
            UiTextFiel().textField(
              labelText: 'Confirmar clave',
              prefixIcon: Icons.lock_outline,
              colorPrefixIcon: primaryColor,
              obscureText: true,
              suffixIcon: Icons.remove_red_eye,
            ),
            const SizedBox(height: 20),
            UiTextFiel().textField(
              labelText: 'Celular',
              prefixIcon: Icons.phone_android_outlined,
              colorPrefixIcon: primaryColor,
            ),
            const SizedBox(height: 20),
            UiTextFiel().textField(
              labelText: 'Fecha nacimiento',
              prefixIcon: Icons.date_range_outlined,
              colorPrefixIcon: primaryColor,
            ),
            const SizedBox(height: 20),
            Obx(
              () => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: primaryColor),
                          child: const Text(
                            'Ingresar',
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
            ),
          ]),
        )),
      ]),
    );
  }
}
