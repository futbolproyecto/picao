import 'package:picao/core/utils/general_model.dart';
import 'package:picao/core/utils/http_service.dart';
import 'package:picao/core/constants/constant_endpoints.dart';
import 'package:picao/modules/team/models/team_data_model.dart';
import 'package:picao/modules/team/models/team_register_model.dart';
import 'package:picao/modules/user/models/user_model.dart';

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
          await HttpService('${ConstantEndpoints.getTeamByUserId}/$idUsuer')
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
}
