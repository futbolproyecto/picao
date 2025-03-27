import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:golpi/modules/home/views/home_page.dart';
import 'package:golpi/modules/team/views/team_page.dart';
import 'package:golpi/modules/home/controller/home_controller.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';

class PrincipalPage extends StatelessWidget {
  const PrincipalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    return PopScope(
      canPop: false,
      child: Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
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
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                              ),
                              child: Icon(
                                Icons.home_outlined,
                                size: 28,
                                color: Theme.of(context).colorScheme.onSurface,
                              )),
                        ),
                        Obx(() => homeController.indexTabBarView.value == 0
                            ? UiText(text: S.of(context).inicio)
                                .paragraphSemiBold()
                            : UiText(text: S.of(context).inicio).paragraph())
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
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                              ),
                              child: Icon(
                                Icons.groups_outlined,
                                size: 28,
                                color: Theme.of(context).colorScheme.onSurface,
                              )),
                        ),
                        Obx(() => homeController.indexTabBarView.value == 1
                            ? UiText(text: S.of(context).equipos)
                                .paragraphSemiBold()
                            : UiText(text: S.of(context).equipos).paragraph())
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
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                              ),
                              child: Icon(
                                Icons.event_available_outlined,
                                size: 28,
                                color: Theme.of(context).colorScheme.onSurface,
                              )),
                        ),
                        Obx(() => homeController.indexTabBarView.value == 2
                            ? UiText(text: S.of(context).encuentros)
                                .paragraphSemiBold()
                            : UiText(text: S.of(context).encuentros)
                                .paragraph())
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
                                    ? Theme.of(context)
                                        .colorScheme
                                        .secondaryContainer
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0)),
                              ),
                              child: Icon(
                                Icons.chat_outlined,
                                size: 28,
                                color: Theme.of(context).colorScheme.onSurface,
                              )),
                        ),
                        Obx(() => homeController.indexTabBarView.value == 3
                            ? UiText(text: S.of(context).chats)
                                .paragraphSemiBold()
                            : UiText(text: S.of(context).chats).paragraph())
                      ],
                    ),
                  ],
                  views: [
                    HomePage(),
                    const TeamPage(),
                    Container(color: Colors.amber),
                    Container(color: Colors.blue)
                  ],
                  tabBarProperties: TabBarProperties(
                      height: 80,
                      background: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
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
                  onChange: (index) =>
                      homeController.changeIndexTabBarView(index),
                  initialIndex: homeController.indexTabBarView.value,
                ),
              ),
              Positioned(
                  top: 35,
                  left: 10,
                  child: UiText(text: 'Golpi').title(
                      color: Theme.of(context).colorScheme.primaryContainer)),
              Positioned(
                top: 35,
                right: 0,
                child: PopupMenuButton<int>(
                  onSelected: (value) {
                    switch (value) {
                      case 1:
                        Get.toNamed(AppPages.profile);
                        break;
                      case 2:
                        break;
                      case 3:
                        homeController.closeSesion();
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: UiText(text: S.of(context).perfil).phrase(),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: UiText(text: S.of(context).ajustes).phrase(),
                    ),
                    PopupMenuItem(
                      value: 3,
                      child: UiText(text: S.of(context).cerrarSesion).phrase(),
                    ),
                  ],
                  icon: Obx(() => Icon(Icons.more_vert,
                      color: homeController.indexTabBarView.value == 0
                          ? Colors.white
                          : Colors.black)),
                ),
              ),
            ],
          ),
          floatingActionButton: Obx(
              () => homeController.floatingActionButton.value ?? SizedBox())),
    );
  }
}
