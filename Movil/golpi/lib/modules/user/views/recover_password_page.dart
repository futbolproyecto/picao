import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:golpi/modules/widgets/curved_background.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';
import 'package:golpi/modules/widgets/ui_text_field.dart';
import 'package:golpi/modules/user/controller/user_controller.dart';

class RecoverPasswordPage extends StatelessWidget {
  const RecoverPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    return Scaffold(
      body: Stack(
        children: [
          CurvedBackground(
            isCurveUp: false,
            height: 300,
          ),
          Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(height: 50),
                  UiText(text: S.of(context).preguntaIniciarSesion)
                      .phrase(color: Theme.of(context).colorScheme.surface),
                  InkWell(
                    onTap: () {
                      Get.offNamed(AppPages.login);
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
                          S.of(context).ingresar,
                          style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer),
                        ))),
                  )
                ],
              ),
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
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            UiText(text: S.of(context).restablecerClave)
                                .title(),
                            const SizedBox(height: 20),
                            Obx(
                              () => Visibility(
                                visible: userController.isValidateEmail.value,
                                child: ReactiveFormBuilder(
                                    form: () => userController
                                        .formEmailRecoveryPassword,
                                    builder: (
                                      BuildContext context,
                                      FormGroup
                                          reactiveFormEmailRecoveryPassword,
                                      Widget? child,
                                    ) {
                                      return Column(
                                        children: [
                                          UiText(
                                                  text: S
                                                      .of(context)
                                                      .correoAsociadoCuenta)
                                              .paragraph(),
                                          const SizedBox(height: 20),
                                          UiTextFiel().textField(
                                            formControlName: 'email',
                                            labelText: S.of(context).correo,
                                            prefixIcon: Icons.email_outlined,
                                            colorPrefixIcon: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            validationMessages: {
                                              ValidationMessage.required:
                                                  (error) => S
                                                      .of(context)
                                                      .campoRequerido,
                                              ValidationMessage.email:
                                                  (error) => S
                                                      .of(context)
                                                      .formatoCorreoIncorrecto,
                                            },
                                          ),
                                          const SizedBox(height: 20),
                                          UiButtoms(
                                                  onPressed: () {
                                                    reactiveFormEmailRecoveryPassword
                                                        .markAllAsTouched();
                                                    if (reactiveFormEmailRecoveryPassword
                                                        .valid) {
                                                      userController
                                                          .sendOtpEmail();
                                                    }
                                                  },
                                                  title: S.of(context).validar)
                                              .primaryButtom(),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                            Obx(() => Visibility(
                                visible: userController.isEmailValidated.value,
                                child: ReactiveFormBuilder(
                                    form: () =>
                                        userController.formChangePassword,
                                    builder: (
                                      BuildContext context,
                                      FormGroup reactiveFormChangePassword,
                                      Widget? child,
                                    ) {
                                      return Column(
                                        children: [
                                          Obx(
                                            () => UiTextFiel().textField(
                                              formControlName: 'password',
                                              labelText: S.of(context).clave,
                                              prefixIcon: Icons.lock_outline,
                                              colorPrefixIcon: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              obscureText: userController
                                                  .obscureText.value,
                                              suffixIcon: IconButton(
                                                  onPressed: userController
                                                      .toggleObscureText,
                                                  icon: Icon(
                                                    userController
                                                            .obscureText.value
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                  )),
                                              validationMessages: {
                                                ValidationMessage.required:
                                                    (error) => S
                                                        .of(context)
                                                        .campoRequerido,
                                                ValidationMessage.maxLength:
                                                    (error) => S
                                                        .of(context)
                                                        .longitudMaximo(50),
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 20),
                                          Obx(
                                            () => UiTextFiel().textField(
                                              formControlName:
                                                  'password_confirmation',
                                              labelText:
                                                  S.of(context).confirmarClave,
                                              prefixIcon: Icons.lock_outline,
                                              colorPrefixIcon: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              obscureText: userController
                                                  .obscureText.value,
                                              suffixIcon: IconButton(
                                                  onPressed: userController
                                                      .toggleObscureText,
                                                  icon: Icon(
                                                    userController
                                                            .obscureText.value
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                  )),
                                              validationMessages: {
                                                ValidationMessage.required:
                                                    (error) => S
                                                        .of(context)
                                                        .campoRequerido,
                                                ValidationMessage.mustMatch:
                                                    (error) => S
                                                        .of(context)
                                                        .claveNoCoincide,
                                                ValidationMessage.maxLength:
                                                    (error) => S
                                                        .of(context)
                                                        .longitudMaximo(50),
                                              },
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Obx(() => Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(S
                                                          .of(context)
                                                          .caracteresEspeciales),
                                                      userController
                                                              .hasEspecialCaracter
                                                              .value
                                                          ? Icon(
                                                              Icons
                                                                  .check_circle_outline,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .error_outline,
                                                              color:
                                                                  Colors.amber,
                                                            )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(S
                                                          .of(context)
                                                          .nCaracteres(6)),
                                                      userController
                                                              .hasMinCaracter
                                                              .value
                                                          ? Icon(
                                                              Icons
                                                                  .check_circle_outline,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .error_outline,
                                                              color:
                                                                  Colors.amber,
                                                            )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(S
                                                          .of(context)
                                                          .mayuscula),
                                                      userController
                                                              .hasCapital.value
                                                          ? Icon(
                                                              Icons
                                                                  .check_circle_outline,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .error_outline,
                                                              color:
                                                                  Colors.amber,
                                                            )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(S
                                                          .of(context)
                                                          .minuscula),
                                                      userController
                                                              .hasLower.value
                                                          ? Icon(
                                                              Icons
                                                                  .check_circle_outline,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .error_outline,
                                                              color:
                                                                  Colors.amber,
                                                            )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(S
                                                          .of(context)
                                                          .numeros),
                                                      userController
                                                              .hasNumber.value
                                                          ? Icon(
                                                              Icons
                                                                  .check_circle_outline,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .secondary,
                                                            )
                                                          : const Icon(
                                                              Icons
                                                                  .error_outline,
                                                              color:
                                                                  Colors.amber,
                                                            )
                                                    ],
                                                  ),
                                                ],
                                              )),
                                          UiButtoms(
                                                  onPressed: () {
                                                    reactiveFormChangePassword
                                                        .markAllAsTouched();
                                                    if (reactiveFormChangePassword
                                                        .valid) {
                                                      userController
                                                          .changePassword();
                                                    }
                                                  },
                                                  title: S.of(context).validar)
                                              .primaryButtom(),
                                        ],
                                      );
                                    })))
                          ],
                        );
                      }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
