import 'package:flutter/material.dart';
import 'package:golpi/core/constants/constants.dart';

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

  Widget phraseSemiBold() {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget phraseBlack() {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        color: Colors.black,
      ),
    );
  }

  Widget phraseWhite() {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 16,
        color: Colors.white,
      ),
    );
  }

  Widget phrasePrimaryColor() {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: Constants.primaryColor),
    );
  }

  Widget paragraphSemiBold() {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Helvetica',
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
    );
  }

  Widget paragraphBlack() {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Helvetica',
        fontSize: 16,
      ),
    );
  }
}
