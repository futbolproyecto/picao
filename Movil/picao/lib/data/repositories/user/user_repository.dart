import 'package:picao/core/constants/constant_endpoints.dart';
import 'package:picao/core/utils/http_service.dart';
import 'package:picao/modules/user/models/change_password_model.dart';
import 'package:picao/modules/user/models/user_model.dart';

class UserRepository {
  Future<void> sendOtp(String mobileNumber) async {
    try {
      await HttpService(ConstantEndpoints.sendOtp)
          .postRequesParam({'mobile_number': mobileNumber});
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> sendOtpEmail(String email) async {
    try {
      await HttpService(ConstantEndpoints.sendOtp)
          .postRequesParam({'email': email});
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> validateOtp(String otp, String mobileNumber) async {
    try {
      await HttpService(ConstantEndpoints.validateOtp)
          .putRequesParam({'otp': otp, 'mobile_number': mobileNumber});
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> validateOtpEmail(String otp, String email) async {
    try {
      await HttpService(ConstantEndpoints.validateOtp)
          .putRequesParam({'otp': otp, 'email': email});
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> registerUser(UserRegisterModel userRegisterModel) async {
    try {
      await HttpService(ConstantEndpoints.createUser)
          .post(userRegisterModel.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> changePassword(ChangePasswordModel changePasswordModel) async {
    try {
      await HttpService(ConstantEndpoints.changePassword)
          .post(changePasswordModel.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }
}
