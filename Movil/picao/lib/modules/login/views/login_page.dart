import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:picao/modules/login/controller/login_controller.dart';
import 'package:picao/modules/widgets/ui_buttoms.dart';
import 'package:picao/modules/widgets/ui_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();

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
            InkWell(
              onTap: () {
                Get.toNamed(AppPages.userRegister);
              },
              child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                      color: secondaryColor.withOpacity(0.5),
                      borderRadius: const BorderRadius.all(Radius.circular(5))),
                  child: const Center(child: Text('Registrar'))),
            )
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
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ReactiveFormBuilder(
                  form: () => loginController.formLogin,
                  builder: (
                    BuildContext context,
                    FormGroup reactiveFormLogin,
                    Widget? child,
                  ) {
                    return Column(children: [
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
                        formControlName: 'mobile_number',
                        labelText: 'Correo',
                        prefixIcon: Icons.email_outlined,
                        colorPrefixIcon: primaryColor,
                        validationMessages: {
                          ValidationMessage.required: (error) =>
                              'Campo requerido',
                        },
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => UiTextFiel().textField(
                          formControlName: 'password',
                          labelText: 'Clave',
                          prefixIcon: Icons.lock_outline,
                          colorPrefixIcon: primaryColor,
                          obscureText: loginController.obscureText.value,
                          suffixIcon: IconButton(
                              onPressed: loginController.toggleObscureText,
                              icon: Icon(
                                loginController.obscureText.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              )),
                          validationMessages: {
                            ValidationMessage.required: (error) =>
                                'Campo requerido',
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      UiButtoms(
                              onPressed: () {
                                reactiveFormLogin.markAllAsTouched();
                                if (reactiveFormLogin.valid) {
                                  loginController.login();
                                }
                              },
                              title: 'Ingresar')
                          .primaryButtom(),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(AppPages.chagePassword);
                          },
                          child: const Text(
                            '¿Olvidaste tu contraseña?',
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ]);
                  });
            },
          ),
        )),
      ]),
    );
  }
}
