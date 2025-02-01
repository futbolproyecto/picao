import 'package:flutter/material.dart';
import 'package:golpi/core/constants/constants.dart';

class UiButtoms {
  final VoidCallback onPressed;
  final String title;

  UiButtoms({
    required this.onPressed,
    required this.title,
  });

  Widget primaryButtom() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Constants.primaryColor,
          foregroundColor: Constants.primaryColor,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget secondaryButtom() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          onPressed;
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Constants.primaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white),
        child: Text(
          title,
          style: TextStyle(fontSize: 18, color: Constants.primaryColor),
        ),
      ),
    );
  }

  Widget textButtom(Color color) {
    return TextButton(
      child: Text(title, style: TextStyle(color: color)),
      onPressed: () => onPressed(),
    );
  }
}
