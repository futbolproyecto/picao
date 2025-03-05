import 'package:golpi/core/utils/http_service.dart';
import 'package:golpi/core/models/option_model.dart';
import 'package:golpi/core/utils/general_model.dart';
import 'package:golpi/modules/user/models/user_model.dart';
import 'package:golpi/core/constants/constant_endpoints.dart';
import 'package:golpi/modules/user/models/user_register_model.dart';
import 'package:golpi/modules/user/models/change_password_model.dart';
import 'package:golpi/modules/user/models/player_profile_register_model.dart';

class UserRepository {
  Future<void> sendOtpMobileNumber(String mobileNumber) async {
    try {
      await HttpService(ConstantEndpoints.sendOtpMobileNumber)
          .postRequesParam({'mobile_number': mobileNumber});
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> sendOtpEmail(String email) async {
    try {
      await HttpService(ConstantEndpoints.sendOtpEmail)
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
      await HttpService(ConstantEndpoints.validateOtpEmail)
          .postRequesParam({'otp': otp, 'email': email});
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
          .put(changePasswordModel.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<UserModel> getUserById(int userId) async {
    try {
      final response =
          await HttpService('${ConstantEndpoints.getUserById}/$userId').get();
      return UserModel.fromJson(GeneralModel().jsonStringifyToMaps(response));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<OptionModel>> getAllZones() async {
    try {
      final response = await HttpService(ConstantEndpoints.getAllZones).get();

      return (GeneralModel().jsonStringifyToList(response))
          .map((i) => OptionModel.fromJson(i))
          .toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<OptionModel>> getAllPositionPlayer() async {
    try {
      final response =
          await HttpService(ConstantEndpoints.getAllPositionPlayer).get();

      return (GeneralModel().jsonStringifyToList(response))
          .map((i) => OptionModel.fromJson(i))
          .toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<OptionModel>> getAllDominantFoot() async {
    try {
      final response =
          await HttpService(ConstantEndpoints.getAllDominantFoot).get();

      return (GeneralModel().jsonStringifyToList(response))
          .map((i) => OptionModel.fromJson(i))
          .toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<OptionModel>> getAllCities() async {
    try {
      final response =
          await HttpService(ConstantEndpoints.getAllCities).get();

      return (GeneralModel().jsonStringifyToList(response))
          .map((i) => OptionModel.fromJson(i))
          .toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> createPlayerProfile(
      PlayerProfileRegisterModel playerProfileRegisterModel) async {
    try {
      await HttpService(ConstantEndpoints.createPlayerProfile)
          .post(playerProfileRegisterModel.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> updatePlayerProfile(
      PlayerProfileRegisterModel playerProfileRegisterModel) async {
    try {
      await HttpService(ConstantEndpoints.updatePlayerProfile)
          .put(playerProfileRegisterModel.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }
}
