import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:picao/modules/user/controller/user_controller.dart';
import 'package:picao/modules/widgets/ui_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
                            formControlName: 'names',
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
                            formControlName: 'surnames',
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
                          const SizedBox(height: 20),
                          UiTextFiel().textField(
                            formControlName: 'cell_phone',
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
                            formControlName: 'birthdate',
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
                            () => userController.isLoading.value
                                ? const CircularProgressIndicator()
                                : Center(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          reactiveFormUserRegistrer
                                              .markAllAsTouched();

                                          if (reactiveFormUserRegistrer.valid) {
                                            userController.registerUser();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            backgroundColor: primaryColor),
                                        child: const Text(
                                          'Ingresar',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ]);
                      });
                }),
          ),
        ),
      ]),
    );
  }
}
