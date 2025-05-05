import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/core/utils/utility.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';
import 'package:golpi/modules/widgets/ui_text_field.dart';
import 'package:golpi/modules/widgets/curved_background.dart';
import 'package:golpi/modules/user/controller/user_controller.dart';

class RegisterUserPage extends StatelessWidget {
  const RegisterUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Scaffold(
      body: Stack(
        children: [
          CurvedBackground(isCurveUp: false),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 50),
                UiText(text: S.of(context).preguntaTienesCuenta)
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
                              UiText(text: S.of(context).registroInformacion)
                                  .title(),
                              const SizedBox(height: 20),
                              UiTextFiel().textField(
                                formControlName: 'name',
                                labelText: S.of(context).nombres,
                                prefixIcon: Icons.person_2_outlined,
                                colorPrefixIcon:
                                    Theme.of(context).colorScheme.primary,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      S.of(context).campoRequerido,
                                  ValidationMessage.maxLength: (error) =>
                                      S.of(context).longitudMaximo(50),
                                },
                              ),
                              const SizedBox(height: 20),
                              UiTextFiel().textField(
                                formControlName: 'last_name',
                                labelText: S.of(context).apellidos,
                                prefixIcon: Icons.person_2_outlined,
                                colorPrefixIcon:
                                    Theme.of(context).colorScheme.primary,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      S.of(context).campoRequerido,
                                  ValidationMessage.maxLength: (error) =>
                                      S.of(context).longitudMaximo(50),
                                },
                              ),
                              const SizedBox(height: 20),
                              UiTextFiel().textField(
                                formControlName: 'email',
                                labelText: S.of(context).correo,
                                prefixIcon: Icons.email_outlined,
                                colorPrefixIcon:
                                    Theme.of(context).colorScheme.primary,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      S.of(context).campoRequerido,
                                  ValidationMessage.email: (error) =>
                                      S.of(context).formatoCorreoIncorrecto,
                                  ValidationMessage.maxLength: (error) =>
                                      S.of(context).longitudMaximo(50),
                                },
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: userController.isLoading.value
                                          ? LinearProgressIndicator()
                                          : ReactiveDropdownField<String>(
                                              formControlName: 'cell_prefix',
                                              decoration: InputDecoration(
                                                labelText: 'Indicativo',
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16.0,
                                                        horizontal: 16.0),
                                                labelStyle: const TextStyle(
                                                  color: Colors.black54,
                                                  fontFamily: 'Montserrat',
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[300]!,
                                                      width: 1),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[200]!),
                                                ),
                                              ),
                                              items: userController.listContries
                                                  .map((country) {
                                                return DropdownMenuItem<String>(
                                                  value: country.cellPrefix,
                                                  child: Row(
                                                    children: [
                                                      Image.asset(
                                                        country.flagAsset,
                                                        width: 24,
                                                        height: 18,
                                                        package:
                                                            'country_icons',
                                                        errorBuilder:
                                                            (_, __, ___) =>
                                                                Icon(Icons.flag,
                                                                    size: 16),
                                                      ),
                                                      SizedBox(width: 6),
                                                      Text(
                                                          '${country.cellPrefix}'),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                              validationMessages: {
                                                ValidationMessage.required:
                                                    (error) => S
                                                        .of(context)
                                                        .campoRequerido,
                                              },
                                            ),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      flex: 7,
                                      child: UiTextFiel().textField(
                                        formControlName: 'mobile_number',
                                        labelText: S.of(context).celular,
                                        textInputType: TextInputType.number,
                                        prefixIcon:
                                            Icons.phone_android_outlined,
                                        colorPrefixIcon: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        validationMessages: {
                                          ValidationMessage.required: (error) =>
                                              S.of(context).campoRequerido,
                                          ValidationMessage.minLength:
                                              (error) => S
                                                  .of(context)
                                                  .longitudMinimo(10),
                                          ValidationMessage.maxLength:
                                              (error) => S
                                                  .of(context)
                                                  .longitudMaximo(50),
                                          ValidationMessage.number: (error) =>
                                              S.of(context).soloNumeros,
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              UiTextFiel().datePickerField(
                                formControlName: 'date_of_birth',
                                labelText: S.of(context).fechaNacimiento,
                                prefixIcon: Icons.date_range_outlined,
                                colorPrefixIcon:
                                    Theme.of(context).colorScheme.primary,
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      S.of(context).campoRequerido,
                                },
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => UiTextFiel().textField(
                                  formControlName: 'password',
                                  labelText: S.of(context).clave,
                                  prefixIcon: Icons.lock_outline,
                                  colorPrefixIcon:
                                      Theme.of(context).colorScheme.primary,
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
                                        S.of(context).campoRequerido,
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => UiTextFiel().textField(
                                  formControlName: 'password_confirmation',
                                  labelText: S.of(context).confirmarClave,
                                  prefixIcon: Icons.lock_outline,
                                  colorPrefixIcon:
                                      Theme.of(context).colorScheme.primary,
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
                                        S.of(context).campoRequerido,
                                    ValidationMessage.mustMatch: (error) =>
                                        S.of(context).claveNoCoincide,
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              Obx(() => Visibility(
                                  visible: userController
                                      .showValidationPassword.value,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(S
                                              .of(context)
                                              .caracteresEspeciales),
                                          userController
                                                  .hasEspecialCaracter.value
                                              ? Icon(
                                                  Icons.check_circle_outline,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
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
                                          Text(S.of(context).nCaracteres(6)),
                                          userController.hasMinCaracter.value
                                              ? Icon(
                                                  Icons.check_circle_outline,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
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
                                          Text(S.of(context).mayuscula),
                                          userController.hasCapital.value
                                              ? Icon(
                                                  Icons.check_circle_outline,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
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
                                          Text(S.of(context).minuscula),
                                          userController.hasLower.value
                                              ? Icon(
                                                  Icons.check_circle_outline,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
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
                                          Text(S.of(context).numeros),
                                          userController.hasNumber.value
                                              ? Icon(
                                                  Icons.check_circle_outline,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                )
                                              : const Icon(
                                                  Icons.error_outline,
                                                  color: Colors.amber,
                                                )
                                        ],
                                      ),
                                    ],
                                  ))),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ReactiveCheckbox(
                                        formControlName: 'terms_and_conditions',
                                      ),
                                      Text(
                                        S.of(context).inicioMensajeTerminos,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface),
                                      ),
                                      UiButtoms(
                                              onPressed: () {},
                                              title: S.of(context).terminos)
                                          .textButtom(Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                      Text(S.of(context).y),
                                      UiButtoms(
                                              onPressed: () {},
                                              title: S.of(context).condiciones)
                                          .textButtom(Theme.of(context)
                                              .colorScheme
                                              .onSurface),
                                    ],
                                  ),
                                  Obx(() {
                                    return Padding(
                                      padding: EdgeInsets.only(left: 50),
                                      child: Text(
                                        userController.termsAndConditionsError
                                                .value ??
                                            '',
                                        style: TextStyle(
                                            color: Color(0xffb00020),
                                            fontSize: 12),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                              const SizedBox(height: 20),
                              UiButtoms(
                                      onPressed: () {
                                        reactiveFormUserRegistrer
                                            .markAllAsTouched();
                                        if (reactiveFormUserRegistrer.valid) {
                                          userController.sendOtpMobileNumber();
                                        } else {
                                          if (userController.formUserRegistrer
                                                  .control(
                                                      'terms_and_conditions')
                                                  .invalid &&
                                              userController.formUserRegistrer
                                                  .control(
                                                      'terms_and_conditions')
                                                  .touched) {
                                            userController
                                                    .termsAndConditionsError
                                                    .value =
                                                S.of(context).aceptarTerminos;
                                          }
                                          Utility.validateAllFields(
                                              reactiveFormUserRegistrer);
                                        }
                                      },
                                      title: S.of(context).ingresar)
                                  .primaryButtom(),
                              const SizedBox(height: 20),
                            ]);
                          });
                    }),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
