import 'package:flutter/material.dart';
import 'package:golpi/modules/widgets/ui_text.dart';
import 'package:golpi/modules/widgets/curved_background.dart';

class MatchesPage extends StatelessWidget {
  const MatchesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
              Align(
                alignment: Alignment.topCenter,
                child: Card(
                  elevation: 3,
                  color: Theme.of(context).colorScheme.surface,
                  child: SizedBox(
                    width: screenSize.width * 0.9,
                    height: 150,
                    child: const Center(child: Text('Proxima reserva')),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(child: UiText(text: 'Mis reservas').phrase()),
            ],
          ),
        ],
      ),
    );
  }
}
