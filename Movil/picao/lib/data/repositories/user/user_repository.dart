import 'package:picao/data/providers/user/user_provider.dart';
import 'package:picao/modules/user/models/user_model.dart';

class UserRepository {
  final UserProvider userProvider;
  UserRepository({required this.userProvider});

  Future<void> sendOtp(String mobileNumber) async {
    try {
      await userProvider.sendOtp(mobileNumber);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> validateOtp(String otp, String mobileNumber) async {
    try {
      await userProvider.validateOtp(otp, mobileNumber);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> registerUser(UserRegisterModel userRegisterModel) async {
    try {
      await userProvider.registerUser(userRegisterModel);
    } on Exception catch (_) {
      rethrow;
    }
  }
}
