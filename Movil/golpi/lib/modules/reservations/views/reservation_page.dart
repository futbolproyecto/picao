import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:golpi/core/routes/app_pages.dart';
import 'package:golpi/generated/l10n.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:golpi/modules/widgets/curved_background.dart';

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
              Center(
                child: UiText(text: S.of(context).eventos)
                    .title(color: Theme.of(context).colorScheme.primary),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppPages.reservationField);
                    },
                    child: Card(
                      elevation: 3,
                      color: Theme.of(context).colorScheme.surface,
                      child: SizedBox(
                        width: 200,
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.sports_soccer_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 60,
                                )),
                            UiText(text: S.of(context).crearReserva)
                                .paragraphSemiBold(
                                    color:
                                        Theme.of(context).colorScheme.primary)
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppPages.listReservationFields);
                    },
                    child: Card(
                      elevation: 3,
                      color: Theme.of(context).colorScheme.surface,
                      child: SizedBox(
                        width: 200,
                        height: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryContainer,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.emoji_events_outlined,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 60,
                                )),
                            UiText(text: S.of(context).misReservas)
                                .paragraphSemiBold(
                                    color:
                                        Theme.of(context).colorScheme.primary)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
