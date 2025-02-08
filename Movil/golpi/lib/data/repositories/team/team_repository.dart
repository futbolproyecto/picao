import 'package:golpi/core/utils/general_model.dart';
import 'package:golpi/core/utils/http_service.dart';
import 'package:golpi/core/constants/constant_endpoints.dart';
import 'package:golpi/modules/team/models/team_data_model.dart';
import 'package:golpi/modules/team/models/team_model.dart';
import 'package:golpi/modules/team/models/team_register_model.dart';
import 'package:golpi/modules/team/models/user_team_model.dart';
import 'package:golpi/modules/user/models/user_model.dart';

class TeamRepository {
  Future<void> createTeam(TeamRegisterModel teamRegisterModel) async {
    try {
      await HttpService(ConstantEndpoints.createTeam)
          .post(teamRegisterModel.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<List<TeamDataModel>> getTeamByUserId(int idUsuer) async {
    try {
      final response =
          await HttpService('${ConstantEndpoints.getTeamsByUserId}/$idUsuer')
              .get();

      return (GeneralModel().jsonStringifyToList(response))
          .map((i) => TeamDataModel.fromJson(i))
          .toList();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<UserModel> getUserByMobileNumber(String mobileNumer) async {
    try {
      final response = await HttpService(
              '${ConstantEndpoints.getUserByMobileNumber}/$mobileNumer')
          .get();
      return UserModel.fromJson(GeneralModel().jsonStringifyToMaps(response));
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> addUserTeam(UserTeamModel userTeamModel) async {
    try {
      await HttpService(ConstantEndpoints.addUserTeam)
          .post(userTeamModel.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<TeamModel> getTeamsByUserId(int userId, int teamId) async {
    try {
      final response = await HttpService(ConstantEndpoints.getTeamByUserId)
          .getRequesParam({"user-id": "$userId", "team-id": "$teamId"});

      return TeamModel.fromJson(GeneralModel().jsonStringifyToMaps(response));
    } on Exception catch (_) {
      rethrow;
    }
  }
}
