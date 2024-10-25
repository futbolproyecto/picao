import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:picao/modules/widgets/ui_text.dart';
import 'package:picao/core/constants/constants.dart';
import 'package:picao/modules/home/controller/home_controller.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: AppBar(
        title: UiText(text: 'Golpi').titlePrimaryColor(),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              offset: const Offset(0, 45),
              color: Colors.white,
              onSelected: (value) {
                // Acción según el valor seleccionado
                switch (value) {
                  case 1:
                    print('Perfil');
                    break;
                  case 2:
                    print('Ajustes');
                    break;
                  case 3:
                    homeController.closeSesion();
                    break;
                }
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: UiText(text: 'Perfil').phraseBlack(),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: UiText(text: 'Ajustes').phraseBlack(),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: UiText(text: 'Salir').phraseBlack(),
                    ),
                  ])
        ],
      ),
      body: Center(
        child: SizedBox(
          child: ContainedTabBarView(
            tabs: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 15),
                        decoration: BoxDecoration(
                          color: homeController.indexTabBarView.value == 0
                              ? Constants.secondaryColor.withAlpha(80)
                              : Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: const Icon(Icons.home_outlined, size: 28)),
                  ),
                  Obx(() => homeController.indexTabBarView.value == 0
                      ? UiText(text: 'Inicio').paragraphSemiBold()
                      : UiText(text: 'Inicio').paragraphBlack())
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 15),
                        decoration: BoxDecoration(
                          color: homeController.indexTabBarView.value == 1
                              ? Constants.secondaryColor.withAlpha(80)
                              : Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: const Icon(Icons.group_add_outlined, size: 28)),
                  ),
                  Obx(() => homeController.indexTabBarView.value == 1
                      ? UiText(text: 'Equipos').paragraphSemiBold()
                      : UiText(text: 'Equipos').paragraphBlack())
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 15),
                        decoration: BoxDecoration(
                          color: homeController.indexTabBarView.value == 2
                              ? Constants.secondaryColor.withAlpha(80)
                              : Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: const Icon(Icons.event_available_outlined,
                            size: 28)),
                  ),
                  Obx(() => homeController.indexTabBarView.value == 2
                      ? UiText(text: 'Encuentros').paragraphSemiBold()
                      : UiText(text: 'Encuentros').paragraphBlack())
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 15),
                        decoration: BoxDecoration(
                          color: homeController.indexTabBarView.value == 3
                              ? Constants.secondaryColor.withAlpha(80)
                              : Colors.transparent,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: const Icon(Icons.chat_outlined, size: 28)),
                  ),
                  Obx(() => homeController.indexTabBarView.value == 3
                      ? UiText(text: 'Chats').paragraphSemiBold()
                      : UiText(text: 'Chats').paragraphBlack())
                ],
              ),
            ],
            tabBarProperties: TabBarProperties(
                height: 80,
                background: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: const Offset(1, -1),
                      ),
                    ],
                  ),
                ),
                position: TabBarPosition.bottom,
                alignment: TabBarAlignment.center,
                indicatorColor: Colors.transparent,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black),
            views: [
              Container(color: Colors.red),
              Container(color: Colors.green),
              Container(color: Colors.amber),
              Container(color: Colors.blue)
            ],
            onChange: (index) => homeController.changeIndexTabBarView(index),
          ),
        ),
      ),
    );
  }
}
