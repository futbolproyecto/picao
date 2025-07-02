import 'package:golpi/core/utils/http_service.dart';
import 'package:golpi/core/utils/general_model.dart';
import 'package:golpi/core/models/option_model.dart';
import 'package:golpi/core/constants/constant_endpoints.dart';
import 'package:golpi/modules/reservations/models/field_available_model.dart';

class ReservationRepository {
  Future<List<FieldAvailableModel>> getFieldAvailable({
    required String cityName,
    String? date,
    String? startTime,
    String? endTime,
  }) async {
    try {
      Map<String, dynamic> requestParam = {
        'city-name': cityName,
        'date': date,
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
}
