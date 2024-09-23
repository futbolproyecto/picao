import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picao/modules/user/controller/login_controller.dart';
import 'package:picao/modules/widgets/ui_text_field.dart';

class LoginPage extends GetView<LoginController> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

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
              '¿No tienes una cuenta?',
              style: TextStyle(
                color: primaryColor,
                fontSize: 14,
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 10),
                width: 80,
                height: 30,
                decoration: BoxDecoration(
                    color: secondaryColor.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: const Center(child: Text('Registrar')))
          ],
        ),
        const SizedBox(height: 40),
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
              'Bienvenido de nuevo',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Ingresa tus datos de sesion',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
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
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(
                    color: primaryColor,
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
