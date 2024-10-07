import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:picao/modules/widgets/ui_buttoms.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:picao/modules/widgets/ui_text_field.dart';
import 'package:picao/modules/user/controller/user_controller.dart';

class UserRegisterPage extends StatelessWidget {
  const UserRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

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
                controller: userController.scrollController,
                itemBuilder: (context, index) {
                  return ReactiveFormBuilder(
                      form: () => userController.formUserRegistrer,
                      builder: (
                        BuildContext context,
                        FormGroup reactiveFormUserRegistrer,
                        Widget? child,
                      ) {
                        return Column(children: [
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
                            formControlName: 'name',
                            labelText: 'Nombres',
                            prefixIcon: Icons.person_2_outlined,
                            colorPrefixIcon: primaryColor,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  'Campo requerido',
                            },
                          ),
                          const SizedBox(height: 20),
                          UiTextFiel().textField(
                            formControlName: 'last_name',
                            labelText: 'Apellidos',
                            prefixIcon: Icons.person_2_outlined,
                            colorPrefixIcon: primaryColor,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  'Campo requerido',
                            },
                          ),
                          const SizedBox(height: 20),
                          UiTextFiel().textField(
                            formControlName: 'email',
                            labelText: 'Correo',
                            prefixIcon: Icons.email_outlined,
                            colorPrefixIcon: primaryColor,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  'Campo requerido',
                            },
                          ),
                          const SizedBox(height: 20),
                          UiTextFiel().textField(
                            formControlName: 'mobile_number',
                            labelText: 'Celular',
                            prefixIcon: Icons.phone_android_outlined,
                            colorPrefixIcon: primaryColor,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  'Campo requerido',
                            },
                          ),
                          const SizedBox(height: 20),
                          UiTextFiel().datePickerField(
                            formControlName: 'date_of_birth',
                            labelText: 'Fecha nacimiento',
                            prefixIcon: Icons.date_range_outlined,
                            colorPrefixIcon: primaryColor,
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
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
                              obscureText: userController.obscureText.value,
                              suffixIcon: IconButton(
                                  onPressed: userController.toggleObscureText,
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
                              colorPrefixIcon: primaryColor,
                              obscureText: userController.obscureText.value,
                              suffixIcon: IconButton(
                                  onPressed: userController.toggleObscureText,
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
                          Obx(() => Visibility(
                              visible:
                                  userController.showValidationPassword.value,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Caracteres especiales'),
                                      userController.hasEspecialCaracter.value
                                          ? const Icon(
                                              Icons.check_circle_outline,
                                              color: secondaryColor,
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
                                          ? const Icon(
                                              Icons.check_circle_outline,
                                              color: secondaryColor,
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
                                          ? const Icon(
                                              Icons.check_circle_outline,
                                              color: secondaryColor,
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
                                          ? const Icon(
                                              Icons.check_circle_outline,
                                              color: secondaryColor,
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
                                          ? const Icon(
                                              Icons.check_circle_outline,
                                              color: secondaryColor,
                                            )
                                          : const Icon(
                                              Icons.error_outline,
                                              color: Colors.amber,
                                            )
                                    ],
                                  ),
                                ],
                              ))),
                          const SizedBox(height: 20),
                          UiButtoms(
                                  onPressed: () {
                                    reactiveFormUserRegistrer
                                        .markAllAsTouched();
                                    if (reactiveFormUserRegistrer.valid) {
                                      userController.sendOtp();
                                    }
                                  },
                                  title: 'Ingresar')
                              .primaryButtom()
                        ]);
                      });
                }),
          ),
        ),
      ]),
    );
  }
}
