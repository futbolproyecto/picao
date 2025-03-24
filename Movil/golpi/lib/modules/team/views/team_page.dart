import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/core/constants/constants.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:golpi/modules/home/controller/home_controller.dart';
import 'package:golpi/modules/team/controller/team_controller.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';
import 'package:golpi/modules/widgets/ui_text.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final HomeController homeController = Get.find<HomeController>();
    final TeamController teamController = Get.find<TeamController>();

    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Card(
              elevation: 3,
              color: Colors.white,
              child: SizedBox(
                width: screenSize.width * 0.8,
                height: 200,
                child: const Center(child: Text('Top 1')),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UiButtoms(onPressed: () {}, title: 'Top 10')
                  .textButtom(Constants.primaryColor),
              UiButtoms(onPressed: () {}, title: 'Mis equipo')
                  .textButtom(Constants.primaryColor),
            ],
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                  itemCount: homeController.listTeams.toList().length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          leading: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Constants.secondaryColor,
                                    width: 3,
                                  )),
                              child: Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Constants.secondaryColor,
                                      width: 3,
                                    )),
                                child: ClipOval(
                                  child: Image.asset('assets/img/teamicon.jpg'),
                                ),
                              )),
                          title: UiText(
                                  text: homeController.listTeams[index].name ??
                                      '')
                              .phraseSemiBold(),
                          subtitle: Column(
                            children: [
                              _buildInfoRow('Posición:',
                                  '${homeController.listTeams[index].positionPlayer}'),
                              _buildInfoRow('Cantidad jugadores:',
                                  '${homeController.listTeams[index].numberOfPlayers}'),
                            ],
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios_outlined,
                              color: Colors.grey),
                          onTap: () {
                            teamController.teamId.value =
                                homeController.listTeams[index].id ?? 0;
                            teamController.getTeamsByUserId(
                                homeController.listTeams[index].id ?? 0);
                            Get.toNamed(AppPages.manageTeam);
                          },
                        ),
                      ),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          UiText(text: label).paragraphSemiBold(),
          UiText(text: value).phraseBlack()
        ],
      ),
    );
  }
}
