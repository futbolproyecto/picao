import 'package:picao/core/utils/http_service.dart';
import 'package:picao/core/constants/constant_endpoints.dart';
import 'package:picao/modules/team/models/team_register_model.dart';

class TeamRepository {
  Future<void> createTeam(TeamRegisterModel teamRegisterModel) async {
    try {
      await HttpService(ConstantEndpoints.createTeam)
          .post(teamRegisterModel.toJson());
    } on Exception catch (_) {
      rethrow;
    }
  }
}
