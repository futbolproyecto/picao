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
import 'package:golpi/modules/team/controller/team_controller.dart';

class RegisterTeamPage extends StatelessWidget {
  const RegisterTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TeamController teamController = Get.find<TeamController>();
    teamController.loadDataTeam();

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
            UiText(text: S.of(context).registrarEquipo)
                .title(color: Colors.white),
            const SizedBox(height: 20),
            ImagePreview(),
            Expanded(
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(children: [
                              UiTextFiel().textField(
                                formControlName: 'team_name',
                                labelText: S.of(context).nombreEquipo,
                                prefixIcon: Icons.group_outlined,
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
                                formControlName: 'representative_name',
                                labelText: S.of(context).representante,
                                prefixIcon: Icons.person_2_outlined,
                                colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      S.of(context).campoRequerido,
                                  ValidationMessage.maxLength: (error) =>
                                      S.of(context).longitudMaximo(50),
                                },
                              ),
                              const SizedBox(height: 20),
                              UiTextFiel().textField(
                                formControlName: 'contact_number',
                                labelText: S.of(context).numeroContacto,
                                prefixIcon: Icons.contact_phone_outlined,
                                colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      S.of(context).campoRequerido,
                                  ValidationMessage.maxLength: (error) =>
                                      S.of(context).longitudMaximo(50),
                                },
                              ),
                              const SizedBox(height: 20),
                              UiTextFiel().dropDownSearch(
                                formControlName: 'city',
                                labelText: S.of(context).ciudad,
                                prefixIcon: Icons.location_city_outlined,
                                colorPrefixIcon: Theme.of(context).colorScheme.primary,
                                items: teamController.listCitiesOption,
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
                                items: teamController.listZonesOption,
                                validationMessages: {
                                  ValidationMessage.required: (error) =>
                                      S.of(context).campoRequerido,
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
                                      title: S.of(context).guardar)
                                  .primaryButtom(),
                              const SizedBox(height: 20),
                            ]),
                          );
                        });
                  }),
            ),
          ]),
        ],
      ),
    );
  }
}
