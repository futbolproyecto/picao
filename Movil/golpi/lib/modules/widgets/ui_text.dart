import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UiText {
  final String text;

  UiText({required this.text});

  Widget title({Color? color}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color),
    );
  }

  Widget phraseSemiBold({Color? color}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: color ?? Theme.of(Get.context!).colorScheme.onSurface),
    );
  }

  Widget phrase({Color? color}) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        color: color ?? Theme.of(Get.context!).colorScheme.onSurface,
      ),
    );
  }

  Widget phrasePrimaryColor() {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: Theme.of(Get.context!).colorScheme.primary),
    );
  }

  Widget paragraphSemiBold({Color? color}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Helvetica',
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: color ?? Theme.of(Get.context!).colorScheme.onSurface),
    );
  }

  Widget paragraph({Color? color}) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Helvetica',
          fontSize: 16,
          color: color ?? Theme.of(Get.context!).colorScheme.onSurface),
    );
  }
}
