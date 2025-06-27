import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:golpi/modules/widgets/curved_background.dart';
import 'package:golpi/modules/widgets/ui_text.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppPages.reservationField);
                      },
                      child: Card(
                        elevation: 3,
                        color: Theme.of(context).colorScheme.surface,
                        child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.sports),
                              UiText(text: 'Reservar cancha')
                                  .paragraphSemiBold()
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 3,
                        color: Theme.of(context).colorScheme.surface,
                        child: SizedBox(
                          width: 150,
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.sports),
                              UiText(text: 'Ver reservas').paragraphSemiBold()
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
