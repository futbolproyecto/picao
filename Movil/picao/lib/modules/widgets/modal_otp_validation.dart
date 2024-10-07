import 'package:flutter/material.dart';
import 'package:picao/modules/widgets/ui_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ModalOtpValidation {
  Widget validateOtp({
    required BuildContext context,
    required FormGroup formOtpConfirmation,
    required String mobileNumber,
  }) {
    final screenSize = MediaQuery.of(context).size;
    const Color primaryColor = Color(0xFF04a57e);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 200,
      width: screenSize.width * 0.99,
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return ReactiveFormBuilder(
                form: () => formOtpConfirmation,
                builder: (
                  BuildContext context,
                  FormGroup reactiveFormUserRegistrer,
                  Widget? child,
                ) {
                  return Column(
                    children: [
                      Text(
                        'Se ha enviado un codigo OTP al numero $mobileNumber, ingresalo para confirmar el registro',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      UiTextFiel().textField(
                        formControlName: 'otp_number',
                        labelText: 'Codigo',
                        prefixIcon: Icons.numbers_outlined,
                        colorPrefixIcon: primaryColor,
                        validationMessages: {
                          ValidationMessage.required: (error) =>
                              'Campo requerido',
                        },
                      ),
                      /* const SizedBox(height: 20),
                      Row(
                        children: [
                          UiButtoms(onPressed: onPressed, title: 'Validar')
                              .primaryButtom()
                        ],
                      ) */
                    ],
                  );
                });
          }),
    );
  }
}
