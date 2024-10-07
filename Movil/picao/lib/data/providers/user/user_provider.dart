import 'package:picao/core/utils/http_service.dart';
import 'package:picao/modules/user/models/user_model.dart';

class UserProvider {
  Future<void> sendOtp(String mobileNumber) async {
    try {
      await HttpService('create').post({'mobile_umber': mobileNumber});
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> registerUser(UserRegisterModel userRegisterModel) async {
    try {
      await HttpService('create').post(userRegisterModel.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }
}
