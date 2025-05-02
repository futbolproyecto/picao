import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final double size;
  final VoidCallback? onTap;

  const ImagePreview({
    super.key,
    this.size = 150,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.green[200],
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(Icons.camera_alt_outlined,
            size: size * 0.5, color: Colors.green),
      ),
    );
  }
}
