import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';
import 'package:golpi/modules/widgets/ui_text_field.dart';
import 'package:golpi/modules/reservations/controller/reservation_controller.dart';

class ReservationFieldPage extends StatelessWidget {
  const ReservationFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ReservationController reservationController =
        Get.find<ReservationController>();
    return Scaffold(
      body: Stack(
        children: [
          UiButtoms().backButtom(),
          Column(
            children: [
              const SizedBox(height: 50),
              UiText(text: S.of(context).buscarEstablecimiento).title(),
              const SizedBox(height: 20),
              ReactiveFormBuilder(
                  form: () => reservationController.formSearchField,
                  builder: (
                    BuildContext context,
                    FormGroup reactiveFormUserRegistrer,
                    Widget? child,
                  ) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Obx(
                        () => ExpansionPanelList(
                            expansionCallback: (_, __) =>
                                reservationController.toggle(),
                            children: [
                              ExpansionPanel(
                                canTapOnHeader: true,
                                headerBuilder: (context, isExpanded) =>
                                    ListTile(
                                        title:
                                            UiText(text: S.of(context).filtros)
                                                .title(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary)),
                                isExpanded:
                                    reservationController.isExpanded.value,
                                body: Obx(
                                  () => reservationController
                                          .isLoadingInitial.value
                                      ? LinearProgressIndicator()
                                      : Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                            children: [
                                              const SizedBox(height: 5),
                                              UiTextFiel().datePickerField(
                                                formControlName: 'date',
                                                labelText:
                                                    S.of(context).fechaReserva,
                                                prefixIcon:
                                                    Icons.date_range_outlined,
                                                colorPrefixIcon:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.now()
                                                    .add(Duration(days: 30)),
                                                validationMessages: {
                                                  ValidationMessage.required:
                                                      (error) => S
                                                          .of(context)
                                                          .campoRequerido,
                                                },
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: UiTextFiel()
                                                        .dropDownHora(
                                                      formControlName:
                                                          'hora_inicio',
                                                      labelText: S
                                                          .of(context)
                                                          .horaInicio,
                                                      prefixIcon: Icons
                                                          .access_time_outlined,
                                                      colorPrefixIcon:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                      context: context,
                                                      form:
                                                          reactiveFormUserRegistrer,
                                                      validationMessages: {
                                                        ValidationMessage
                                                                .required:
                                                            (error) => S
                                                                .of(context)
                                                                .campoRequerido,
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Expanded(
                                                    child: UiTextFiel()
                                                        .dropDownHora(
                                                      formControlName:
                                                          'hora_fin',
                                                      labelText:
                                                          S.of(context).horaFin,
                                                      prefixIcon: Icons
                                                          .access_time_outlined,
                                                      colorPrefixIcon:
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .primary,
                                                      context: context,
                                                      form:
                                                          reactiveFormUserRegistrer,
                                                      validationMessages: {
                                                        ValidationMessage
                                                                .required:
                                                            (error) => S
                                                                .of(context)
                                                                .campoRequerido,
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              UiTextFiel().dropDownSearch(
                                                formControlName: 'ubicacion',
                                                labelText:
                                                    S.of(context).ubicacion,
                                                prefixIcon:
                                                    Icons.location_on_outlined,
                                                colorPrefixIcon:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                items: reservationController
                                                    .listCitiesOption,
                                                onChangeFuncion: () {
                                                  reservationController
                                                      .loadEstablishment();
                                                },
                                                validationMessages: {
                                                  ValidationMessage.required:
                                                      (error) => S
                                                          .of(context)
                                                          .campoRequerido,
                                                },
                                              ),
                                              const SizedBox(height: 20),
                                              UiTextFiel().dropDownSearch(
                                                formControlName:
                                                    'establecimiento',
                                                labelText: S
                                                    .of(context)
                                                    .establecimiento,
                                                prefixIcon:
                                                    Icons.business_outlined,
                                                colorPrefixIcon:
                                                    Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                items: reservationController
                                                    .lisEstablishmentsOptions,
                                                validationMessages: {
                                                  ValidationMessage.required:
                                                      (error) => S
                                                          .of(context)
                                                          .campoRequerido,
                                                },
                                              ),
                                              const SizedBox(height: 20),
                                              UiButtoms(
                                                      title: S.of(context).buscar,
                                                      onPressed: () =>
                                                          reservationController
                                                              .getFieldsAvailable())
                                                  .primaryButtom(),
                                              const SizedBox(height: 20),
                                            ],
                                          ),
                                        ),
                                ),
                              ),
                            ]),
                      ),
                    );
                  }),
              SizedBox(height: 20),
              Obx(() => reservationController.isLoading.value
                  ? LinearProgressIndicator()
                  : SizedBox()),
              Expanded(
                child: Obx(
                  () {
                    return ListView.builder(
                        itemCount:
                            reservationController.fieldAvailableList.length,
                        itemBuilder: (context, index) {
                          return Obx(
                            () {
                              final isSelected =
                                  reservationController.isSelected(index);
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Card(
                                  elevation: 3,
                                  color: Theme.of(context).colorScheme.surface,
                                  child: ListTile(
                                    tileColor: isSelected
                                        ? Theme.of(context)
                                            .colorScheme
                                            .secondaryContainer
                                        : null,
                                    onTap: () => reservationController
                                        .toggleSelection(index),
                                    trailing: isSelected
                                        ? Icon(Icons.check_box,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary)
                                        : Icon(Icons.check_box_outline_blank),
                                    leading: Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .secondary,
                                            width: 3,
                                          )),
                                      child: ClipOval(
                                        child: Image.asset(
                                            'assets/img/usericon.png'),
                                      ),
                                    ),
                                    title: UiText(
                                            text:
                                                '${reservationController.fieldAvailableList[index].nameEstablishment}')
                                        .phraseSemiBold(),
                                    subtitle: Column(
                                      children: [
                                        _buildInfoRow(
                                            '${S.of(context).direccion}:',
                                            '${reservationController.fieldAvailableList[index].addressEstablishment}'),
                                        _buildInfoRow('${S.of(context).fecha}:',
                                            '${reservationController.fieldAvailableList[index].date}'),
                                        _buildInfoRow(
                                            '${S.of(context).cancha}:',
                                            '${reservationController.fieldAvailableList[index].nameField}'),
                                        _buildInfoRow('${S.of(context).hora}:',
                                            '${reservationController.fieldAvailableList[index].startTime}'),
                                        _buildInfoRow(
                                            '${S.of(context).tarifa}:',
                                            '${reservationController.fieldAvailableList[index].fee}'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        });
                  },
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: FloatingActionButton(
            onPressed: () {
              reservationController.confirmReservation();
            },
            backgroundColor:
                Theme.of(Get.context!).colorScheme.secondaryContainer,
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    Icons.event_available_outlined,
                    size: 30,
                    color: Theme.of(Get.context!).colorScheme.secondary,
                  ),
                ),
                Positioned(
                  top: 3,
                  right: 3,
                  child: Icon(
                    Icons.add_circle_sharp,
                    size: 20,
                    color: Theme.of(Get.context!).colorScheme.primary,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [UiText(text: label).phrase(), UiText(text: value).phrase()],
      ),
    );
  }
}
