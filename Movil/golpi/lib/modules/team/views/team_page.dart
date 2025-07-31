import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:golpi/modules/widgets/ui_buttoms.dart';
import 'package:golpi/modules/widgets/curved_background.dart';
import 'package:golpi/modules/team/controller/team_controller.dart';
import 'package:golpi/modules/home/controller/home_controller.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final HomeController homeController = Get.find<HomeController>();
    final TeamController teamController = Get.find<TeamController>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: CurvedBackground(
                isCurveUp: false,
                isBottom: true,
                height: 200,
              )),
          Column(
            children: [
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    UiText(text: 'Top equipos').phrase(),
                    UiButtoms(onPressed: () {}, title: 'Ver todo').textButtom(
                        color: Theme.of(context).colorScheme.primaryContainer)
                  ],
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Card(
                  elevation: 3,
                  color: Theme.of(context).colorScheme.surface,
                  child: SizedBox(
                    width: screenSize.width * 0.9,
                    height: 150,
                    child: const Center(child: Text('Top 1')),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                  child: UiText(text: 'Mis equipos')
                      .phrase(color: Theme.of(context).colorScheme.primary)),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                      itemCount: homeController.listTeams.toList().length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Card(
                            elevation: 3,
                            color: Theme.of(context).colorScheme.surface,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                leading: ClipOval(
                                  child: Image.asset(
                                      homeController.listTeams[index].image ??
                                          'asset/img/teamicon.jpg'),
                                ),
                                title: UiText(
                                        text: homeController
                                                .listTeams[index].name ??
                                            '')
                                    .phraseSemiBold(),
                                subtitle: Column(
                                  children: [
                                    _buildInfoRow(
                                        '${S.of(context).cantidadJugadores}:',
                                        '${homeController.listTeams[index].numberOfPlayers}'),
                                  ],
                                ),
                                trailing: const Icon(
                                    Icons.arrow_forward_ios_outlined,
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
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 2, bottom: 2, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [UiText(text: label).phrase(), UiText(text: value).phrase()],
      ),
    );
  }
}
