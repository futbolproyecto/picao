import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/core/constants/constant_secure_storage.dart';
import 'package:golpi/core/utils/utility.dart';
import 'package:golpi/data/service/secure_storage.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/modules/widgets/modal_otp_validation.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:golpi/core/models/option_model.dart';
import 'package:golpi/core/exception/custom_exception.dart';
import 'package:golpi/modules/widgets/ui_alert_message.dart';
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

  var isLoadingInitial = false.obs;
  var isLoading = false.obs;
  var errorModel = Rx<ErrorModel?>(null);
  var fieldAvailableList = <FieldAvailableModel>[].obs;
  var listCitiesOption = [OptionModel()].obs;
  var lisEstablishmentsOptions = <OptionModel>[].obs;
  var isExpanded = true.obs;
  var selectedItems = <int>{}.obs;

  var formSearchField = FormGroup({
    'date': FormControl<DateTime>(),
    'hora_inicio': FormControl<TimeOfDay>(),
    'hora_fin': FormControl<TimeOfDay>(),
    'tipo': FormControl<OptionModel>(),
    'ubicacion': FormControl<OptionModel>(validators: [Validators.required]),
    'establecimiento': FormControl<OptionModel>(),
  });

  var formOtpConfirmation = FormGroup({
    'otp_number': FormControl<String>(
      validators: [Validators.required, Validators.maxLength(50)],
    ),
  });

  void toggle() => isExpanded.value = !isExpanded.value;

  Future<void> loadData() async {
    try {
      isLoadingInitial.value = true;

      listCitiesOption.value = await reservationRepository.getCities();

      isLoadingInitial.value = false;
    } on CustomException catch (e) {
      isLoadingInitial.value = false;
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  Future<void> loadEstablishment() async {
    try {
      isLoadingInitial.value = true;

      final cityId = formSearchField.control('ubicacion').value.id;

      if (cityId != null) {
        lisEstablishmentsOptions.value =
            await reservationRepository.getEstablishmentsByCity(
                formSearchField.control('ubicacion').value.id);
      }

      isLoadingInitial.value = false;
    } on CustomException catch (e) {
      isLoadingInitial.value = false;
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      isLoadingInitial.value = false;
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  Future<void> getFieldsAvailable() async {
    try {
      if (formSearchField.valid) {
        isLoading.value = true;

        final cityName = listCitiesOption.firstWhere(
          (element) {
            return element.id == formSearchField.control('ubicacion').value.id;
          },
        );

        final establishmentName = lisEstablishmentsOptions.firstWhereOrNull(
          (element) {
            return element.id ==
                formSearchField.control('establecimiento').value?.id;
          },
        );

        fieldAvailableList.value =
            await reservationRepository.getFieldAvailable(
          cityName: cityName.name ?? '',
          date: Utility().formatDate(formSearchField.control('date').value),
          establishmentName: establishmentName?.name,
          startTime: Utility()
              .formatHour(formSearchField.control('hora_inicio').value),
          endTime:
              Utility().formatHour(formSearchField.control('hora_fin').value),
        );

        isLoading.value = false;
        isExpanded.value = false;
      } else {
        formSearchField.markAllAsTouched();
      }
    } on CustomException catch (e) {
      isLoading.value = false;
      fieldAvailableList.value = [];
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      isLoading.value = false;
      fieldAvailableList.value = [];
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  void toggleSelection(int index) {
    if (selectedItems.contains(index)) {
      selectedItems.remove(index);
    } else {
      selectedItems.add(index);
    }
  }

  bool isSelected(int index) => selectedItems.contains(index);

  Future<void> confirmReservation() async {
    if (selectedItems.isEmpty) {
      UiAlertMessage(Get.context!).error(message: S().seleccionCanchaVacia);
      return;
    }

    final firstItem = fieldAvailableList[selectedItems.first];
    final firstEstablishment = firstItem.nameEstablishment;
    final firstDate = firstItem.date;
    final firstField = firstItem.nameField;
    List<int> hours = [];

    for (var index in selectedItems) {
      final item = fieldAvailableList[index];

      if (item.nameEstablishment != firstEstablishment) {
        UiAlertMessage(Get.context!)
            .error(message: S().establecimientosDistintos);
        return;
      }

      if (item.date != firstDate) {
        UiAlertMessage(Get.context!).error(message: S().fechasDistintas);
        return;
      }

      if (item.nameField != firstField) {
        UiAlertMessage(Get.context!).error(message: S().canchasDistintas);
        return;
      }

      // Validar consecutividad de horas
      hours = selectedItems.map((index) {
        final timeStr = fieldAvailableList[index].startTime;
        return int.parse(timeStr!.split(":")[0]);
      }).toList();

      hours.sort();

      for (int i = 1; i < hours.length; i++) {
        if (hours[i] != hours[i - 1] + 1) {
          UiAlertMessage(Get.context!).error(message: S().harariosDistintos);
          return;
        }
      }
    }

    String mensajeHorario = S().mensajeHorario1('${hours[0]}:00');

    if (hours.length > 1) {
      mensajeHorario =
          S().mensajeHorario2('${hours.first}:00', '${hours.last}:00');
    }

    UiAlertMessage(Get.context!).alert(
        message: S().confirmacionReserva(
          firstItem.nameEstablishment!.toUpperCase(),
          firstItem.nameField!,
          firstItem.date!,
          mensajeHorario,
        ),
        actions: [
          UiButtoms(
                  onPressed: () async {
                    Get.back();
                    await sendOtpMobileNumber();
                  },
                  title: S().reservar)
              .textButtom(
                  color: Theme.of(Get.context!).colorScheme.primaryContainer),
          UiButtoms(
                  onPressed: () {
                    Get.back();
                  },
                  title: S().cancelar)
              .textButtom(),
        ]);
  }

  Future<void> sendOtpMobileNumber() async {
    try {
      QuickAlert.show(
        context: Get.context!,
        type: QuickAlertType.loading,
        title: 'Cargando...',
        text: 'Confirmando informacion',
        barrierDismissible: false,
        disableBackBtn: true,
      );

      /* await userRepository.sendOtpMobileNumber(
          '${formUserRegistrer.control('cell_prefix').value}${formUserRegistrer.control('mobile_number').value}');
 */

      final mobileNumber =
          await SecureStorage().read(ConstantSecureStorage.mobileNumber);
      Get.back();
      UiAlertMessage(Get.context!).custom(
          child: ModalOtpValidation().validateOtp(
            context: Get.context!,
            formOtpConfirmation: formOtpConfirmation,
            mobileNumber: mobileNumber ?? '¡Error!',
          ),
          actions: [
            UiButtoms(
                    onPressed: () async {
                      await validateOtp();
                    },
                    title: S().validar)
                .textButtom(
                    color: Theme.of(Get.context!).colorScheme.primaryContainer),
            UiButtoms(
                    onPressed: () {
                      Get.back();
                    },
                    title: S().cerrar)
                .textButtom(),
          ]);
    } on CustomException catch (e) {
      Get.back();
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      Get.back();
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }

  Future<void> validateOtp() async {
    try {
      if (formOtpConfirmation.valid) {
        QuickAlert.show(
          context: Get.context!,
          type: QuickAlertType.loading,
          title: 'Cargando...',
          text: 'Validando otp',
          barrierDismissible: false,
          disableBackBtn: true,
        );

        /* await userRepository.validateOtp(
            formOtpConfirmation.control('otp_number').value,
            formUserRegistrer.control('mobile_number').value); */

        Get.back();
        formOtpConfirmation.reset();
        // registerUser();
        getFieldsAvailable();
      } else {
        formOtpConfirmation.markAllAsTouched();
      }
    } on CustomException catch (e) {
      Get.back();
      formOtpConfirmation.reset();
      UiAlertMessage(Get.context!)
          .error(message: '${e.error.error}\n${e.error.recommendation}');
    } on Exception catch (_) {
      Get.back();
      formOtpConfirmation.reset();
      UiAlertMessage(Get.context!).error(
          message:
              '${ErrorModel().uncontrolledError().error!}\n${ErrorModel().uncontrolledError().recommendation!}');
    }
  }
}
