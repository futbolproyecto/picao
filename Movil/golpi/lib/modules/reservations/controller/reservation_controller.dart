import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golpi/modules/widgets/ui_alert_message.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/core/models/option_model.dart';
import 'package:golpi/core/exception/custom_exception.dart';
import 'package:golpi/core/exception/models/error_model.dart';
import 'package:golpi/modules/reservations/models/field_available_model.dart';
import 'package:golpi/data/repositories/reservation/reservation_repository.dart';

class ReservationController extends GetxController {
  final ReservationRepository reservationRepository;

  ReservationController({required this.reservationRepository});

  @override
  void onReady() async {
    loadData();
    super.onReady();
  }

  var isLoading = false.obs;
  var errorModel = Rx<ErrorModel?>(null);
  var fieldAvailableList = <FieldAvailableModel>[].obs;
  var listCitiesOption = [OptionModel()].obs;

  var formSearchField = FormGroup({
    'date': FormControl<DateTime>(),
    'hora_inicio': FormControl<TimeOfDay>(),
    'hora_fin': FormControl<TimeOfDay>(),
    'tipo': FormControl<OptionModel>(),
    'ubicacion': FormControl<OptionModel>(),
  });

  Future<void> loadData() async {
    try {
      isLoading.value = true;

      listCitiesOption.value = await reservationRepository.getCities();

      isLoading.value = false;
    } on CustomException catch (e) {
      isLoading.value = false;
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  Future<void> getFieldsAvailable() async {
    try {
      if (formSearchField.valid) {
        isLoading.value = true;

        await reservationRepository.getFieldAvailable(
          cityName: 'Cali',
          date: '2025-05-29',
          hour: '00:00',
          //establishmentName: 'GolpiGroup',
        );

        fieldAvailableList.value = [
          FieldAvailableModel(
              nameEstablishment: 'GolpiGroup',
              addressEstablishment: 'Cll 56',
              startTime: '--')
        ];

        isLoading.value = false;
      } else {
        formSearchField.markAllAsTouched();
      }
    } on CustomException catch (e) {
      isLoading.value = false;
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }
}
