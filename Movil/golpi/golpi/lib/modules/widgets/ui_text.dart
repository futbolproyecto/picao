import 'package:flutter/material.dart';
import 'package:golpi/core/constants/constants.dart';

class UiText {
  final String text;

  UiText({required this.text});

  Widget title() {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget titlePrimaryColor() {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Constants.primaryColor),
    );
  }

  Widget phraseSemiBold() {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget phraseBlack() {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Montserrat',
        fontSize: 14,
        color: Colors.black,
      ),
    );
  }

  Widget phrasePrimaryColor() {
    return Text(
      text,
      style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 14,
          color: Constants.primaryColor),
    );
  }

  Widget paragraphSemiBold() {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Helvetica',
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget paragraphBlack() {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Helvetica',
        fontSize: 14,
      ),
    );
  }
}
