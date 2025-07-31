import 'package:flutter/material.dart';
import 'package:golpi/modules/widgets/ui_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ModalOtpValidation {
  Widget validateOtp({
    required BuildContext context,
    required FormGroup formOtpConfirmation,
    required String message
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
                form: () => formOtpConfirmation,
                builder: (
                  BuildContext context,
                  FormGroup reactiveFormUserRegistrer,
                  Widget? child,
                ) {
                  return Column(
                    children: [
                      Text(
                        message,
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
                    ],
                  );
                });
          }),
    );
  }

  Widget validateOtpEmail({
    required BuildContext context,
    required FormGroup formOtpEmailConfirmation,
    required String email,
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
                form: () => formOtpEmailConfirmation,
                builder: (
                  BuildContext context,
                  FormGroup reactiveFormOtpEmailConfirmation,
                  Widget? child,
                ) {
                  return Column(
                    children: [
                      Text(
                        'Se ha enviado un codigo OTP al correo $email, por favor revisa tu bandeja de entrada o tu carpeta de spam. ingresalo para continuar',
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
                    ],
                  );
                });
          }),
    );
  }
}
