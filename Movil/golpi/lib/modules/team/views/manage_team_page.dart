import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:golpi/modules/team/views/team_players_page.dart';
import 'package:golpi/modules/team/controller/team_controller.dart';

class ManageTeamPage extends StatelessWidget {
  const ManageTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final TeamController teamController = Get.find<TeamController>();

    return Scaffold(
      appBar: AppBar(
        title: UiText(text: 'Administrar equipo').titlePrimaryColor(),
      ),
      body: Column(
        children: [
          Obx(
            () => Align(
              alignment: Alignment.topCenter,
              child: Card(
                elevation: 3,
                color: Colors.white,
                child: SizedBox(
                  width: screenSize.width * 0.8,
                  height: 200,
                  child: Center(
                      child: teamController.isLoading.value
                          ? SizedBox()
                          : Text('${teamController.teamModel.value!.name}')),
                ),
              ),
            ),
          ),
          Expanded(child: TeamPlayers())
        ],
      ),
    );
  }
}
