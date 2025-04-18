import 'package:flutter/material.dart';

/// Define el fondo de los formularios y/o pantallas
/// de la aplicacion, se debe usar con un stack.
/// Se puede usar en dos casos, cuando el componente
/// esta en la parte superior o en la parte inferior, para
/// los dos se configura la opcion de que la curva quede
/// hacia arriba o hacia abajo.
/// Cuando el componente se use en la parte inferior se debe llamar de
/// la siguiente manera en el stack:
/// Positioned( bottom: 0,left: 0,right: 0, child: CurvedBackground(isCurveUp: false,isBottom: true,))

class CurvedBackground extends StatelessWidget {
  final bool isCurveUp;
  final bool isBottom;
  final double height;

  const CurvedBackground({
    super.key,
    required this.isCurveUp,
    this.isBottom = false,
    this.height = 300,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CurvedClipper(isCurveUp: isCurveUp, isBottom: isBottom),
      child: Container(
        width: double.infinity,
        height: height,
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}

class CurvedClipper extends CustomClipper<Path> {
  final bool isCurveUp;
  final bool isBottom;

  CurvedClipper({required this.isCurveUp, required this.isBottom});

  @override
  Path getClip(Size size) {
    Path path = Path();

    if (isBottom) {
      if (isCurveUp) {
        path.moveTo(0, size.height * 0.2);
        path.quadraticBezierTo(
          size.width / 2,
          -size.height * 0.2,
          size.width,
          size.height * 0.2,
        );

        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
      } else {
        path.moveTo(0, 0);
        path.quadraticBezierTo(
          size.width / 2,
          size.height * 0.4,
          size.width,
          0,
        );

        path.lineTo(size.width, size.height);
        path.lineTo(0, size.height);
      }
    } else {
      if (isCurveUp) {
        path.moveTo(0, 0);
        path.lineTo(size.width, 0);

        path.lineTo(size.width, size.height - 70);
        path.quadraticBezierTo(
          size.width / 2,
          size.height - 140,
          0,
          size.height - 70,
        );
      } else {
        path.lineTo(0, size.height - 70);
        path.quadraticBezierTo(
          size.width / 2,
          size.height,
          size.width,
          size.height - 70,
        );
        path.lineTo(size.width, 0);
      }
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
