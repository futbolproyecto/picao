import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picao/core/constants/constants.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:picao/modules/user/controller/user_controller.dart';
import 'package:picao/modules/widgets/ui_buttoms.dart';
import 'package:picao/modules/widgets/ui_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class RecoverPasswordPage extends StatelessWidget {
  const RecoverPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();
    return Scaffold(
      //appBar: AppBar(backgroundColor: Constants.primaryColor),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(height: 50),
              Text(
                '¿Ya tienes una cuenta?',
                style: TextStyle(
                  color: Constants.primaryColor,
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
                        color: Constants.secondaryColor.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                    child: const Center(child: Text('Ingresar'))),
              )
            ],
          ),
          const SizedBox(height: 20),
          Visibility(
            visible: userController.isValidateEmail.value,
            child: Expanded(
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
                          form: () => userController.formEmailRecoveryPassword,
                          builder: (
                            BuildContext context,
                            FormGroup reactiveFormEmailRecoveryPassword,
                            Widget? child,
                          ) {
                            return Column(
                              children: [
                                const Text(
                                  'Restablecer contraseña',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Por favor, introduce el correo electrónico asociado a tu cuenta para recuperar tu contraseña.',
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                UiTextFiel().textField(
                                  formControlName: 'email',
                                  labelText: 'Correo',
                                  prefixIcon: Icons.email_outlined,
                                  colorPrefixIcon: Constants.primaryColor,
                                  validationMessages: {
                                    ValidationMessage.required: (error) =>
                                        'Campo requerido',
                                  },
                                ),
                                const SizedBox(height: 20),
                                UiButtoms(
                                        onPressed: () {
                                          reactiveFormEmailRecoveryPassword
                                              .markAllAsTouched();
                                          if (reactiveFormEmailRecoveryPassword
                                              .valid) {
                                            userController.sendOtp();
                                          }
                                        },
                                        title: 'Validar')
                                    .primaryButtom(),
                              ],
                            );
                          });
                    }),
              ),
            ),
          ),
          /*Visibility(
              visible: userController.isEmailValidated.value,
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return ReactiveFormBuilder(
                        form: () => userController.formChangePassword,
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
                                  labelText: 'Clave',
                                  prefixIcon: Icons.lock_outline,
                                  colorPrefixIcon: Constants.primaryColor,
                                  obscureText: userController.obscureText.value,
                                  suffixIcon: IconButton(
                                      onPressed:
                                          userController.toggleObscureText,
                                      icon: Icon(
                                        userController.obscureText.value
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
                              Obx(
                                () => UiTextFiel().textField(
                                  formControlName: 'password_confirmation',
                                  labelText: 'Confirmar clave',
                                  prefixIcon: Icons.lock_outline,
                                  colorPrefixIcon: Constants.primaryColor,
                                  obscureText: userController.obscureText.value,
                                  suffixIcon: IconButton(
                                      onPressed:
                                          userController.toggleObscureText,
                                      icon: Icon(
                                        userController.obscureText.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      )),
                                  validationMessages: {
                                    ValidationMessage.required: (error) =>
                                        'Campo requerido',
                                    ValidationMessage.mustMatch: (error) =>
                                        'La contraseña no coincide',
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Obx(() => Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Caracteres especiales'),
                                          userController
                                                  .hasEspecialCaracter.value
                                              ? Icon(
                                                  Icons.check_circle_outline,
                                                  color:
                                                      Constants.secondaryColor,
                                                )
                                              : const Icon(
                                                  Icons.error_outline,
                                                  color: Colors.amber,
                                                )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('6 caracteres'),
                                          userController.hasMinCaracter.value
                                              ? Icon(
                                                  Icons.check_circle_outline,
                                                  color:
                                                      Constants.secondaryColor,
                                                )
                                              : const Icon(
                                                  Icons.error_outline,
                                                  color: Colors.amber,
                                                )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Mayuscula'),
                                          userController.hasCapital.value
                                              ? Icon(
                                                  Icons.check_circle_outline,
                                                  color:
                                                      Constants.secondaryColor,
                                                )
                                              : const Icon(
                                                  Icons.error_outline,
                                                  color: Colors.amber,
                                                )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Minuscula'),
                                          userController.hasLower.value
                                              ? Icon(
                                                  Icons.check_circle_outline,
                                                  color:
                                                      Constants.secondaryColor,
                                                )
                                              : const Icon(
                                                  Icons.error_outline,
                                                  color: Colors.amber,
                                                )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Numeros'),
                                          userController.hasNumber.value
                                              ? Icon(
                                                  Icons.check_circle_outline,
                                                  color:
                                                      Constants.secondaryColor,
                                                )
                                              : const Icon(
                                                  Icons.error_outline,
                                                  color: Colors.amber,
                                                )
                                        ],
                                      ),
                                    ],
                                  )),
                              UiButtoms(
                                      onPressed: () {
                                        reactiveFormChangePassword
                                            .markAllAsTouched();
                                        if (reactiveFormChangePassword.valid) {
                                          userController.sendOtpEmail();
                                        }
                                      },
                                      title: 'Validar')
                                  .primaryButtom(),
                            ],
                          );
                        });
                  }))*/
        ],
      ),
    );
  }
}
