import 'package:flutter/material.dart';
import 'package:golpi/core/constants/constants.dart';

/// Define el fondo de los formularios y/o pantallas
/// de la aplicacion, se debe usar con un stack.
/// Cuando isCurveUp sea igual a true se debe usar
/// Positioned( bottom: 0,left: 0,right: 0, child: CurvedBackground())
class CurvedBackground extends StatelessWidget {
  final bool isCurveUp;
  final double height;

  const CurvedBackground({
    super.key,
    required this.isCurveUp,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedClipper(isCurveUp: isCurveUp),
      child: Container(
        width: double.infinity,
        height: height,
        color: Constants.secondaryColor,
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  final bool isCurveUp;

  CurvedClipper({required this.isCurveUp});

  @override
  Path getClip(Size size) {
    Path path = Path();

    if (isCurveUp) {
      path.moveTo(0, 40);
      path.quadraticBezierTo(
        size.width / 2,
        0,
        size.width,
        40,
      );
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else {
      path.lineTo(0, size.height - 40);
      path.quadraticBezierTo(
        size.width / 2,
        size.height,
        size.width,
        size.height - 40,
      );
      path.lineTo(size.width, 0);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
