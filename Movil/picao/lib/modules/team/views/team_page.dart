import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picao/core/constants/constants.dart';
import 'package:picao/core/routes/app_pages.dart';
import 'package:picao/modules/widgets/ui_buttoms.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
            child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(AppPages.manageTeam);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: Colors.white,
                        elevation: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Constants.secondaryColor,
                                    width: 3,
                                  )),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/img/teamicon.jpg',
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                            ),
                            const Icon(Icons.arrow_forward_ios_outlined)
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
