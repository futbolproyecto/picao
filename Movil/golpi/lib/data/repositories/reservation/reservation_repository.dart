import 'package:golpi/core/utils/http_service.dart';
import 'package:golpi/core/utils/general_model.dart';
import 'package:golpi/core/models/option_model.dart';
import 'package:golpi/core/constants/constant_endpoints.dart';
import 'package:golpi/modules/reservations/models/field_available_model.dart';
import 'package:golpi/modules/team/models/reserve_request_model.dart';

class ReservationRepository {
  Future<List<FieldAvailableModel>> getFieldAvailable({
    required String cityName,
    String? date,
    String? establishmentName,
    String? startTime,
    String? endTime,
  }) async {
    try {
      Map<String, dynamic> requestParam = {
        'city-name': cityName,
        'date': date,
        'establishment-name': establishmentName,
        'start-time': startTime,
        'end-time': endTime,
      }..removeWhere((key, value) => value == null);

      final response = await HttpService(ConstantEndpoints.getFieldAvailable)
          .getRequesParam(requestParam);

      return (GeneralModel().jsonStringifyToList(response))
          .map((i) => FieldAvailableModel.fromJson(i))
          .toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<OptionModel>> getCities() async {
    try {
      final response = await HttpService(ConstantEndpoints.getAllCities).get();

      return (GeneralModel().jsonStringifyToList(response))
          .map((i) => OptionModel.fromJson(i))
          .toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<OptionModel>> getEstablishmentsByCity(int cityId) async {
    try {
      final response = await HttpService(
              '${ConstantEndpoints.getEstablishmentByCity}/$cityId')
          .get();

      return (GeneralModel().jsonStringifyToList(response))
          .map((i) => OptionModel.fromJson(i))
          .toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> sendOtpMobileNumber({
    required String mobileNumber,
    bool isReserve = false,
  }) async {
    try {
      await HttpService(ConstantEndpoints.sendOtpMobileNumber).postRequesParam(
          {'mobile_number': mobileNumber, 'is_reserve': isReserve.toString()});
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> reserve(ReserveRequestModel reserveRequestModel) async {
    try {
      await HttpService(ConstantEndpoints.agendaRerve)
          .post(reserveRequestModel.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }
}
