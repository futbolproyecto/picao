import 'package:flutter/material.dart';
import 'package:picao/modules/widgets/ui_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ModalOtpValidation {
  Future<dynamic> modal({
    required BuildContext context,
    required FormGroup formOtpConfirmation,
    double? borderRadius,
    bool? barrierDismissible,
  }) {
    final screenSize = MediaQuery.of(context).size;
    const Color primaryColor = Color(0xFF04a57e);
    return showDialog<String>(
        context: context,
        barrierDismissible: barrierDismissible ?? false,
        builder: (BuildContext context) => Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 0.1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 20.0)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              height: 400,
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
                              const Text(
                                'Se ha enviado un codigo OTP al numero, ingresalo para confirmar el registro',
                                style: TextStyle(
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
            )

            /*SingleChildScrollView(
          child: Container(
            width: screenSize.width * width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius ?? 20.0),
            ),
            child: Center(
              child: Padding(
                padding: padding,
                child: child,
              ),
            ),
          ),
        ),*/
            ));
  }
}
