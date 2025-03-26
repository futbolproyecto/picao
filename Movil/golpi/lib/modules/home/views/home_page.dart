import 'package:flutter/material.dart';
import 'package:golpi/modules/widgets/curved_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        CurvedBackground(isCurveUp: true),
      ],
    ));
  }
}
