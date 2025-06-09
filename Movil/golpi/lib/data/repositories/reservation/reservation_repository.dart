import 'package:golpi/core/utils/http_service.dart';
import 'package:golpi/core/utils/general_model.dart';
import 'package:golpi/core/models/option_model.dart';
import 'package:golpi/core/constants/constant_endpoints.dart';
import 'package:golpi/modules/reservations/models/field_available_model.dart';

class ReservationRepository {
  Future<List<FieldAvailableModel>> getFieldAvailable(
    String cityName,
    String date,
    int hour,
    String establishmentName,
  ) async {
    try {
      final response = await HttpService(ConstantEndpoints.getFieldAvailable)
          .getRequesParam({
        "city_name": cityName,
        "date": date,
        "hour": "$hour",
        "establishment_name": establishmentName,
      });

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
