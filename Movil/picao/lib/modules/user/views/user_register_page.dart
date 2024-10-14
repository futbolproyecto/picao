import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:picao/core/constants/constants.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:picao/modules/widgets/ui_buttoms.dart';
import 'package:picao/modules/widgets/ui_text.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:picao/modules/widgets/ui_text_field.dart';
import 'package:picao/modules/user/controller/user_controller.dart';

class UserRegisterPage extends StatelessWidget {
  const UserRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Scaffold(
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(height: 50),
            UiText(text: '¿Ya tienes una cuenta?').phraseBlack(),
            InkWell(
              onTap: () {
                Get.offNamed(AppPages.login);
              },
              child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                      color: Constants.primaryColor,
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
                          UiText(text: 'Registro de informacion').title(),
                          const SizedBox(height: 20),
                          UiTextFiel().textField(
                            formControlName: 'name',
                            labelText: 'Nombres',
                            prefixIcon: Icons.person_2_outlined,
                            colorPrefixIcon: Constants.primaryColor,
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
                            colorPrefixIcon: Constants.primaryColor,
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
                            colorPrefixIcon: Constants.primaryColor,
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
                            colorPrefixIcon: Constants.primaryColor,
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
                            colorPrefixIcon: Constants.primaryColor,
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
                              colorPrefixIcon: Constants.primaryColor,
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
                              colorPrefixIcon: Constants.primaryColor,
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
                                          ? Icon(
                                              Icons.check_circle_outline,
                                              color: Constants.secondaryColor,
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
                                              color: Constants.secondaryColor,
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
                                              color: Constants.secondaryColor,
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
                                              color: Constants.secondaryColor,
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
                                              color: Constants.secondaryColor,
                                            )
                                          : const Icon(
                                              Icons.error_outline,
                                              color: Colors.amber,
                                            )
                                    ],
                                  ),
                                ],
                              ))),
                          Row(
                            children: [
                              ReactiveCheckbox(
                                  formControlName: 'terms_and_conditions'),
                              const Text('Acepto los '),
                              UiButtoms(onPressed: () {}, title: 'Terminos')
                                  .textButtom(Colors.black),
                              const Text('y'),
                              UiButtoms(onPressed: () {}, title: 'Condiciones')
                                  .textButtom(Colors.black),
                            ],
                          ),
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
                              .primaryButtom(),
                          const SizedBox(height: 20),
                        ]);
                      });
                }),
          ),
        ),
      ]),
    );
  }
}
