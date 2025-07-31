import 'package:golpi/core/utils/general_model.dart';
import 'package:golpi/core/utils/http_service.dart';
import 'package:golpi/core/constants/constant_endpoints.dart';
import 'package:golpi/modules/login/models/login_request_model.dart';
import 'package:golpi/modules/login/models/sesion_model.dart';

class LoginRepository {
  Future<SesionModel> login(LoginRequestModel loginRequestModel) async {
    try {
      final response = await HttpService(ConstantEndpoints.login)
          .post(loginRequestModel.toJson());

      return SesionModel.fromJson(GeneralModel().jsonStringifyToMaps(response));
    } on Exception catch (_) {
      rethrow;
    }
  }
}
