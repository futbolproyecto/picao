import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/core/utils/utility.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/core/constants/constants.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';
import 'package:golpi/modules/widgets/ui_text_field.dart';
import 'package:golpi/modules/user/controller/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();

    return Scaffold(
      appBar: AppBar(
        title: UiText(text: 'Perfil').titlePrimaryColor(),
        automaticallyImplyLeading: true,
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(height: 40),
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
                  return Column(
                    children: [
                      ReactiveFormBuilder(
                          form: () => profileController.formUserInfo,
                          builder: (
                            BuildContext context,
                            FormGroup reactiveFormUserInfo,
                            Widget? child,
                          ) {
                            return Column(children: [
                              const SizedBox(height: 10),
                              UiText(text: 'Mi perfil').title(),
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
                            ]);
                          }),
                      ReactiveFormBuilder(
                          form: () => profileController.formProfile,
                          builder: (
                            BuildContext context,
                            FormGroup reactiveFormProfileRegistrer,
                            Widget? child,
                          ) {
                            return Column(children: [
                              const SizedBox(height: 20),
                              UiTextFiel().textField(
                                formControlName: 'nickname',
                                labelText: 'Alias',
                                prefixIcon: Icons.face_outlined,
                                colorPrefixIcon: Constants.primaryColor,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      'Campo requerido',
                                },
                              ),
                              const SizedBox(height: 20),
                              UiTextFiel().dropDownSearch(
                                formControlName: 'position_player',
                                labelText: 'Posicion',
                                prefixIcon: Icons.flag_outlined,
                                colorPrefixIcon: Constants.primaryColor,
                                items:
                                    profileController.listPositionPlayerOption,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      'Campo requerido',
                                },
                              ),
                              const SizedBox(height: 20),
                              UiTextFiel().textField(
                                formControlName: 'weight',
                                labelText: 'Peso (KG)',
                                textInputType: TextInputType.number,
                                prefixIcon: Icons.fitness_center_outlined,
                                colorPrefixIcon: Constants.primaryColor,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      'Campo requerido'
                                },
                              ),
                              const SizedBox(height: 20),
                              UiTextFiel().textField(
                                formControlName: 'stature',
                                labelText: 'Estatura (CM)',
                                textInputType: TextInputType.number,
                                prefixIcon: Icons.height_outlined,
                                colorPrefixIcon: Constants.primaryColor,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      'Campo requerido',
                                },
                              ),
                              const SizedBox(height: 20),
                              UiTextFiel().dropDownSearch(
                                formControlName: 'dominant_foot',
                                labelText: 'Pie dominante',
                                prefixIcon: Icons.directions_run_outlined,
                                colorPrefixIcon: Constants.primaryColor,
                                items: profileController.listDominantFootOption,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      'Campo requerido',
                                },
                              ),
                              const SizedBox(height: 20),
                              UiTextFiel().dropDownSearch(
                                formControlName: 'city',
                                labelText: 'Ciudad',
                                prefixIcon: Icons.location_city_outlined,
                                colorPrefixIcon: Constants.primaryColor,
                                items: profileController.listCitiesOption,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      'Campo requerido',
                                },
                              ),
                              const SizedBox(height: 20),
                              UiTextFiel().dropDownSearch(
                                formControlName: 'zone',
                                labelText: 'Zona',
                                prefixIcon: Icons.place_outlined,
                                colorPrefixIcon: Constants.primaryColor,
                                items: profileController.listZonesOption,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      'Campo requerido',
                                },
                              ),
                              const SizedBox(height: 20),
                              UiButtoms(
                                      onPressed: () {
                                        reactiveFormProfileRegistrer
                                            .markAllAsTouched();

                                        if (reactiveFormProfileRegistrer
                                            .valid) {
                                          profileController.savePlayerProfile();
                                        } else {
                                          Utility.validateAllFields(
                                              reactiveFormProfileRegistrer);
                                        }
                                      },
                                      title: 'Guardar')
                                  .primaryButtom(),
                              const SizedBox(height: 20),
                            ]);
                          }),
                    ],
                  );
                }),
          ),
        ),
      ]),
    );
  }
}
