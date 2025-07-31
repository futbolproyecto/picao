import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/core/utils/utility.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';
import 'package:golpi/modules/widgets/image_preview.dart';
import 'package:golpi/modules/widgets/ui_text_field.dart';
import 'package:golpi/modules/widgets/curved_background.dart';
import 'package:golpi/modules/user/controller/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    return Scaffold(
      body: Stack(
        children: [
          CurvedBackground(
            isCurveUp: true,
            height: 300,
          ),
          UiButtoms().backButtom(),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 50),
            UiText(text: S.of(context).perfil).title(color: Colors.white),
            const SizedBox(height: 20),
            ImagePreview(),
            Expanded(
              child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ReactiveFormBuilder(
                            form: () => profileController.formUserInfo,
                            builder: (
                              BuildContext context,
                              FormGroup reactiveFormUserInfo,
                              Widget? child,
                            ) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(children: [
                                  UiTextFiel().textField(
                                    formControlName: 'name',
                                    labelText: S.of(context).nombres,
                                    prefixIcon: Icons.person_2_outlined,
                                    colorPrefixIcon:
                                        Theme.of(context).colorScheme.primary,
                                    validationMessages: {
                                      ValidationMessage.required: (error) =>
                                          S.of(context).campoRequerido,
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  UiTextFiel().textField(
                                    formControlName: 'last_name',
                                    labelText: S.of(context).apellidos,
                                    prefixIcon: Icons.person_2_outlined,
                                    colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                    validationMessages: {
                                      ValidationMessage.required: (error) =>
                                          S.of(context).campoRequerido,
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  UiTextFiel().textField(
                                    formControlName: 'email',
                                    labelText: S.of(context).correo,
                                    prefixIcon: Icons.email_outlined,
                                    colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                    validationMessages: {
                                      ValidationMessage.required: (error) =>
                                          S.of(context).campoRequerido,
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  UiTextFiel().textField(
                                    formControlName: 'mobile_number',
                                    labelText: S.of(context).celular,
                                    prefixIcon: Icons.phone_android_outlined,
                                    colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                    validationMessages: {
                                      ValidationMessage.required: (error) =>
                                          S.of(context).campoRequerido,
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  UiTextFiel().datePickerField(
                                    formControlName: 'date_of_birth',
                                    labelText: S.of(context).fechaNacimiento,
                                    prefixIcon: Icons.date_range_outlined,
                                    colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    validationMessages: {
                                      ValidationMessage.required: (error) =>
                                          S.of(context).campoRequerido,
                                    },
                                  ),
                                ]),
                              );
                            }),
                        ReactiveFormBuilder(
                            form: () => profileController.formProfile,
                            builder: (
                              BuildContext context,
                              FormGroup reactiveFormProfileRegistrer,
                              Widget? child,
                            ) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(children: [
                                  const SizedBox(height: 20),
                                  UiTextFiel().textField(
                                    formControlName: 'nickname',
                                    labelText: S.of(context).alias,
                                    prefixIcon: Icons.face_outlined,
                                    colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                    validationMessages: {
                                      ValidationMessage.required: (error) =>
                                          S.of(context).campoRequerido,
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  UiTextFiel().dropDownSearch(
                                    formControlName: 'position_player',
                                    labelText: S.of(context).posicion,
                                    prefixIcon: Icons.flag_outlined,
                                    colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                    items: profileController
                                        .listPositionPlayerOption,
                                    validationMessages: {
                                      ValidationMessage.required: (error) =>
                                          S.of(context).campoRequerido,
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  UiTextFiel().textField(
                                    formControlName: 'weight',
                                    labelText: S.of(context).pesoKg,
                                    textInputType: TextInputType.number,
                                    prefixIcon: Icons.fitness_center_outlined,
                                    colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                    validationMessages: {
                                      ValidationMessage.required: (error) =>
                                          S.of(context).campoRequerido
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  UiTextFiel().textField(
                                    formControlName: 'stature',
                                    labelText: S.of(context).estaturaCm,
                                    textInputType: TextInputType.number,
                                    prefixIcon: Icons.height_outlined,
                                    colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                    validationMessages: {
                                      ValidationMessage.required: (error) =>
                                          S.of(context).campoRequerido,
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  UiTextFiel().dropDownSearch(
                                    formControlName: 'dominant_foot',
                                    labelText: S.of(context).pieDominante,
                                    prefixIcon: Icons.directions_run_outlined,
                                    colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                    items: profileController
                                        .listDominantFootOption,
                                    validationMessages: {
                                      ValidationMessage.required: (error) =>
                                          S.of(context).campoRequerido,
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  UiTextFiel().dropDownSearch(
                                    formControlName: 'city',
                                    labelText: S.of(context).ciudad,
                                    prefixIcon: Icons.location_city_outlined,
                                    colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                    items: profileController.listCitiesOption,
                                    validationMessages: {
                                      ValidationMessage.required: (error) =>
                                          S.of(context).campoRequerido,
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  UiTextFiel().dropDownSearch(
                                    formControlName: 'zone',
                                    labelText: S.of(context).zona,
                                    prefixIcon: Icons.place_outlined,
                                    colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                    items: profileController.listZonesOption,
                                    validationMessages: {
                                      ValidationMessage.required: (error) =>
                                          S.of(context).campoRequerido,
                                    },
                                  ),
                                  const SizedBox(height: 20),
                                  UiButtoms(
                                          onPressed: () {
                                            reactiveFormProfileRegistrer
                                                .markAllAsTouched();

                                            if (reactiveFormProfileRegistrer
                                                .valid) {
                                              profileController
                                                  .savePlayerProfile();
                                            } else {
                                              Utility.validateAllFields(
                                                  reactiveFormProfileRegistrer);
                                            }
                                          },
                                          title: S.of(context).guardar)
                                      .primaryButtom(),
                                  const SizedBox(height: 20),
                                ]),
                              );
                            }),
                      ],
                    );
                  }),
            ),
          ]),
        ],
      ),
    );
  }
}
