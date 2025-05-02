import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';
import 'package:golpi/modules/widgets/ui_text_field.dart';
import 'package:golpi/modules/widgets/curved_background.dart';
import 'package:golpi/modules/login/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();

    return Scaffold(
        body: Stack(
      children: [
        CurvedBackground(
          isCurveUp: false,
          height: 350,
        ),
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 50),
              UiText(text: S.of(context).preguntaRegistrar)
                  .phrase(color: Theme.of(context).colorScheme.surface),
              InkWell(
                onTap: () {
                  Get.toNamed(AppPages.userRegister);
                },
                child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    width: 80,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: Center(
                        child: Text(
                      S.of(context).registrar,
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer),
                    ))),
              )
            ],
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/img/golpilogo.png',
            width: 80,
          ),
          UiText(text: 'Golpi')
              .title(color: Theme.of(context).colorScheme.primaryContainer),
          const SizedBox(height: 20),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
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
              controller: ScrollController(),
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
                        UiText(text: S.of(context).bienvenido).title(
                            color: Theme.of(context).colorScheme.onSurface),
                        const SizedBox(height: 10),
                        UiText(text: S.of(context).ingresaDatosSesion).phrase(
                            color: Theme.of(context).colorScheme.onSurface),
                        const SizedBox(height: 20),
                        UiTextFiel().textField(
                          formControlName: 'email_or_mobile_number',
                          labelText: S.of(context).correoCelular,
                          prefixIcon: Icons.email_outlined,
                          colorPrefixIcon:
                              Theme.of(context).colorScheme.primary,
                          validationMessages: {
                            ValidationMessage.required: (error) =>
                                S.of(context).campoRequerido,
                            ValidationMessage.maxLength: (error) =>
                                S.of(context).longitudMaximo(50),
                          },
                        ),
                        const SizedBox(height: 20),
                        Obx(
                          () => UiTextFiel().textField(
                            formControlName: 'password',
                            labelText: S.of(context).clave,
                            prefixIcon: Icons.lock_outline,
                            colorPrefixIcon:
                                Theme.of(context).colorScheme.primary,
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
                                  S.of(context).campoRequerido,
                              ValidationMessage.maxLength: (error) =>
                                  S.of(context).longitudMaximo(50),
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
                                title: S.of(context).ingresar)
                            .primaryButtom(),
                        Center(
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(AppPages.chagePassword);
                            },
                            child:
                                UiText(text: S.of(context).preguntaOlvidoClave)
                                    .phrase(),
                          ),
                        ),
                      ]);
                    });
              },
            ),
          )),
        ]),
      ],
    ));
  }
}
