import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                      child: Column(
                        children: [
                          UiTextFiel().datePickerField(
                            formControlName: 'date',
                            labelText: S.of(context).fechaReserva,
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
                          Row(
                            children: [
                              Expanded(
                                child: UiTextFiel().dropDownHora(
                                  formControlName: 'hora_inicio',
                                  labelText: S.of(context).horaInicio,
                                  prefixIcon: Icons.access_time_outlined,
                                  colorPrefixIcon:
                                      Theme.of(context).colorScheme.primary,
                                  context: context,
                                  form: reactiveFormUserRegistrer,
                                  validationMessages: {
                                    ValidationMessage.required: (error) =>
                                        S.of(context).campoRequerido,
                                  },
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: UiTextFiel().dropDownHora(
                                  formControlName: 'hora_fin',
                                  labelText: S.of(context).horaFin,
                                  prefixIcon: Icons.access_time_outlined,
                                  colorPrefixIcon:
                                      Theme.of(context).colorScheme.primary,
                                  context: context,
                                  form: reactiveFormUserRegistrer,
                                  validationMessages: {
                                    ValidationMessage.required: (error) =>
                                        S.of(context).campoRequerido,
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          UiTextFiel().dropDownSearch(
                            formControlName: 'ubicacion',
                            labelText: S.of(context).ubicacion,
                            prefixIcon: Icons.location_on_outlined,
                            colorPrefixIcon:
                                Theme.of(context).colorScheme.primary,
                            items: reservationController.listCitiesOption,
                            onChangeFuncion: () {
                              reservationController.loadEstablishment();
                            },
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  S.of(context).campoRequerido,
                            },
                          ),
                          const SizedBox(height: 20),
                          UiTextFiel().dropDownSearch(
                            formControlName: 'establecimiento',
                            labelText: S.of(context).establecimiento,
                            prefixIcon: Icons.business_outlined,
                            colorPrefixIcon:
                                Theme.of(context).colorScheme.primary,
                            items:
                                reservationController.lisEstablishmentsOptions,
                            validationMessages: {
                              ValidationMessage.required: (error) =>
                                  S.of(context).campoRequerido,
                            },
                          ),
                          const SizedBox(height: 20),
                          UiButtoms(
                              title: S.of(context).buscar,
                              onPressed: () => reservationController
                                  .getFieldsAvailable()).primaryButtom()
                        ],
                      ),
                    );
                  }),
              SizedBox(height: 20),
              Obx(
                () => reservationController.isLoading.value
                    ? Center(child: LinearProgressIndicator())
                    : Expanded(
                        child: ListView.builder(
                            itemCount:
                                reservationController.fieldAvailableList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Card(
                                  elevation: 3,
                                  color: Theme.of(context).colorScheme.surface,
                                  child: ListTile(
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
                                        _buildInfoRow('${S.of(context).dia}:',
                                            '${reservationController.fieldAvailableList[index].dayOfWeek}'),
                                        _buildInfoRow('${S.of(context).hora}:',
                                            '${reservationController.fieldAvailableList[index].startTime}'),
                                        _buildInfoRow(
                                            '${S.of(context).Tarifa}:',
                                            '${reservationController.fieldAvailableList[index].fee}'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
              )
            ],
          )
        ],
      ),
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
