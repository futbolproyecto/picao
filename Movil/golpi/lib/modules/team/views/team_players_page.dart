import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:golpi/modules/team/controller/team_controller.dart';

class TeamPlayers extends StatelessWidget {
  const TeamPlayers({super.key});

  @override
  Widget build(BuildContext context) {
    final TeamController teamController = Get.find<TeamController>();

    return Column(
      children: [
        const SizedBox(height: 15),
        InkWell(
          onTap: teamController.openModalSearchUserPhone,
          child: Icon(
            Icons.person_add_alt,
            size: 40,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Obx(
          () => teamController.isLoading.value
              ? Center(child: LinearProgressIndicator())
              : Expanded(
                  child: ListView.builder(
                      itemCount:
                          teamController.teamModel.value?.players?.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Card(
                            elevation: 3,
                            color: Theme.of(context).colorScheme.surface,
                            child: ListTile(
                              leading: Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      width: 3,
                                    )),
                                child: ClipOval(
                                  child: Image.asset('assets/img/usericon.png'),
                                ),
                              ),
                              title: UiText(
                                      text:
                                          '${teamController.teamModel.value?.players?[index].name} ${teamController.teamModel.value?.players?[index].lastName}')
                                  .phraseSemiBold(),
                              subtitle: Column(
                                children: [
                                  _buildInfoRow('${S.of(context).alias}:',
                                      '${teamController.teamModel.value?.players?[index].nickName}'),
                                  _buildInfoRow('${S.of(context).rol}:',
                                      '${teamController.teamModel.value?.players?[index].positionPlayer}'),
                                ],
                              ),
                            ),
                          ),
                        );
                      })),
        )
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [UiText(text: label).phrase(), UiText(text: value).phrase()],
      ),
    );
  }
}
