import 'package:picao/core/utils/http_service.dart';
import 'package:picao/core/constants/constant_endpoints.dart';
import 'package:picao/modules/login/models/login_request_model.dart';

class LoginRepository {
  Future<Map<String, dynamic>> login(
      LoginRequestModel loginRequestModel) async {
    try {
      return await HttpService(ConstantEndpoints.login)
          .post(loginRequestModel.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }
}
