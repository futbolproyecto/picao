import 'package:flutter/material.dart';
import 'package:golpi/modules/user/models/user_model.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:golpi/modules/widgets/ui_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ModalSearchUserPhonePage {
  Widget modalUserPhone({
    required BuildContext context,
    required FormGroup formMobileNumer,
  }) {
    final screenSize = MediaQuery.of(context).size;

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
                      UiText(
                        text:
                            'Ingresa el numero de celular del jugador para buscarlo',
                      ).phrase(),
                      const SizedBox(height: 20),
                      UiTextFiel().textField(
                        formControlName: 'mobile_phone',
                        labelText: 'Numero celular',
                        prefixIcon: Icons.phone_android_outlined,
                        colorPrefixIcon: Theme.of(context).colorScheme.primary,
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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 130,
      width: screenSize.width * 0.99,
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  UiText(text: 'Datos del jugador').title(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UiText(
                        text: 'Nombre: ',
                      ).paragraphSemiBold(),
                      UiText(
                        text: '${userModel.name} ${userModel.lastName}',
                      ).paragraph(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UiText(
                        text: 'Email: ',
                      ).paragraphSemiBold(),
                      UiText(
                        text: userModel.email ?? '',
                      ).paragraph(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UiText(
                        text: 'Celular: ',
                      ).paragraphSemiBold(),
                      UiText(
                        text: userModel.mobileNumber ?? '',
                      ).paragraph(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      UiText(
                        text: 'Alias: ',
                      ).paragraphSemiBold(),
                      UiText(
                        text: userModel.nickName ?? '',
                      ).paragraph(),
                    ],
                  )
                ],
              ),
            );
          }),
    );
  }
}
