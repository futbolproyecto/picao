import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UiButtoms {
  final VoidCallback? onPressed;
  final String? title;

  UiButtoms({
    this.onPressed,
    this.title,
  });

  Widget primaryButtom() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onPressed!(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Theme.of(Get.context!).colorScheme.primaryContainer,
          foregroundColor: Theme.of(Get.context!).colorScheme.primaryContainer,
        ),
        child: Text(
          title!,
          style: TextStyle(
            fontSize: 18,
            color: Theme.of(Get.context!).colorScheme.onPrimaryContainer,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget textButtom({Color? color}) {
    return TextButton(
      child: Container(
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
            color: color ?? Colors.red[100],
            borderRadius: BorderRadius.circular(5)),
        child: Text(title!,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontFamily: 'Helvetica',
              fontSize: 16,
            )),
      ),
      onPressed: () => onPressed!(),
    );
  }

  Widget backButtom() {
    return Positioned(
      top: 40,
      left: 10,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(Get.context!).colorScheme.secondaryContainer,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(Icons.arrow_back,
                size: 40 * 0.5,
                color: Theme.of(Get.context!).colorScheme.secondary),
          ),
        ),
      ),
    );
  }
}
