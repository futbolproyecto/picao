import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/core/utils/utility.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:golpi/core/constants/constants.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';
import 'package:golpi/modules/widgets/ui_text_field.dart';
import 'package:golpi/modules/team/controller/team_controller.dart';

class RegisterTeamPage extends StatelessWidget {
  const RegisterTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TeamController teamController = Get.find<TeamController>();
    teamController.loadDataTeam();

    return Scaffold(
      appBar: AppBar(
        title: UiText(text: 'Equipo').titlePrimaryColor(),
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
                  return ReactiveFormBuilder(
                      form: () => teamController.formTeamRegistrer,
                      builder: (
                        BuildContext context,
                        FormGroup reactiveFormTeamRegistrer,
                        Widget? child,
                      ) {
                        return Column(children: [
                          const SizedBox(height: 10),
                          UiText(text: 'Registrar equipo').title(),
                          const SizedBox(height: 20),
                          UiTextFiel().textField(
                            formControlName: 'team_name',
                            labelText: 'Nombre del equipo',
                            prefixIcon: Icons.group_outlined,
                            colorPrefixIcon: Constants.primaryColor,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  'Campo requerido',
                              ValidationMessage.maxLength: (error) =>
                                  'Maximo 50 caracteres',
                            },
                          ),
                          const SizedBox(height: 20),
                          UiTextFiel().textField(
                            formControlName: 'representative_name',
                            labelText: 'Representante',
                            prefixIcon: Icons.person_2_outlined,
                            colorPrefixIcon: Constants.primaryColor,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  'Campo requerido',
                              ValidationMessage.maxLength: (error) =>
                                  'Maximo 50 caracteres',
                            },
                          ),
                          const SizedBox(height: 20),
                          UiTextFiel().textField(
                            formControlName: 'contact_number',
                            labelText: 'Numero de contacto',
                            prefixIcon: Icons.contact_phone_outlined,
                            colorPrefixIcon: Constants.primaryColor,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  'Campo requerido',
                              ValidationMessage.maxLength: (error) =>
                                  'Maximo 50 caracteres',
                            },
                          ),
                          const SizedBox(height: 20),
                          UiTextFiel().dropDownSearch(
                            formControlName: 'city',
                            labelText: 'Ciudad',
                            prefixIcon: Icons.location_city_outlined,
                            colorPrefixIcon: Constants.primaryColor,
                            items: teamController.listCitiesOption,
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
                            items: teamController.listZonesOption,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  'Campo requerido',
                            },
                          ),
                          const SizedBox(height: 20),
                          UiButtoms(
                                  onPressed: () {
                                    reactiveFormTeamRegistrer
                                        .markAllAsTouched();
                                    if (reactiveFormTeamRegistrer.valid) {
                                      teamController.registerTeam();
                                    } else {
                                      Utility.validateAllFields(
                                          reactiveFormTeamRegistrer);
                                    }
                                  },
                                  title: 'Guardar')
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
