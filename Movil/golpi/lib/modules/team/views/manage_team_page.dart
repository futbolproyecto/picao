import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:golpi/core/constants/constants.dart';
import 'package:golpi/modules/team/views/team_players_page.dart';
import 'package:golpi/modules/home/controller/home_controller.dart';
import 'package:golpi/modules/team/controller/team_controller.dart';

class ManageTeamPage extends StatelessWidget {
  const ManageTeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final TeamController teamController = Get.find<TeamController>();
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: UiText(text: S.of(context).administrarEquipo)
            .title(color: Constants.primaryColor),
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
                  child: Column(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Constants.secondaryColor,
                                width: 3,
                              )),
                          child: Container(
                            width: 100,
                            height: 100,
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
                      Center(
                          child: teamController.errorModel.value != null ||
                                  teamController.isLoading.value
                              ? SizedBox()
                              : UiText(
                                      text:
                                          '${teamController.teamModel.value?.name}')
                                  .phraseSemiBold()),
                      Text('Slogan'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UiText(text: 'Creado por:').paragraphSemiBold(),
                            UiText(text: 'Pepito perez').paragraphBlack(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            UiText(text: 'Fecha creacion:').paragraphSemiBold(),
                            UiText(text: '2024-12-24').paragraphBlack(),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              teamController.modalLeaveTeam(homeController);
                            },
                            child: Container(
                              width: 60,
                              height: 70,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 2.0,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.exit_to_app_outlined,
                                      color: Colors.red,
                                    ),
                                    UiText(text: S.of(context).salir)
                                        .paragraphBlack()
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Container(
                            width: 60,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.chat_outlined,
                                    color: Constants.primaryColor,
                                  ),
                                  UiText(text: 'Chat').paragraphBlack()
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 10)
                    ],
                  ),
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
