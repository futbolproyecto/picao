import 'package:flutter/material.dart';
import 'package:picao/modules/user/models/user_model.dart';
import 'package:picao/modules/widgets/ui_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ModalSearchUserPhonePage {
  Widget modalUserPhone({
    required BuildContext context,
    required FormGroup formMobileNumer,
  }) {
    final screenSize = MediaQuery.of(context).size;
    const Color primaryColor = Color(0xFF04a57e);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 130,
      width: screenSize.width * 0.99,
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return ReactiveFormBuilder(
                form: () => formMobileNumer,
                builder: (
                  BuildContext context,
                  FormGroup reactiveFormMobileNumer,
                  Widget? child,
                ) {
                  return Column(
                    children: [
                      Text(
                        'Ingresa el numero de celular del jugador para buscarlo',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      UiTextFiel().textField(
                        formControlName: 'mobile_phone',
                        labelText: 'Numero celular',
                        prefixIcon: Icons.phone_android_outlined,
                        colorPrefixIcon: primaryColor,
                        validationMessages: {
                          ValidationMessage.required: (error) =>
                              'Campo requerido',
                        },
                      ),
                    ],
                  );
                });
          }),
    );
  }

  Widget modalUserInformation({
    required BuildContext context,
    required UserModel userModel,
  }) {
    final screenSize = MediaQuery.of(context).size;
    const Color primaryColor = Color(0xFF04a57e);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 130,
      width: screenSize.width * 0.99,
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Text(
                  'Datos del jugador',
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      'Nombre: ',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "${userModel.name} ${userModel.lastName}",
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Email: ',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      userModel.email,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Celular: ',
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      userModel.mobileNumber,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            );
          }),
    );
  }
}
