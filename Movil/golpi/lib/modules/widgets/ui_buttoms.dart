import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:golpi/core/constants/constants.dart';

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
          backgroundColor: Constants.primaryColor,
          foregroundColor: Constants.primaryColor,
        ),
        child: Text(
          title!,
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
          title!,
          style: TextStyle(fontSize: 18, color: Constants.primaryColor),
        ),
      ),
    );
  }

  Widget textButtom(Color color) {
    return TextButton(
      child: Text(title!,
          style: TextStyle(
            color: color,
            decoration: TextDecoration.underline,
            fontFamily: 'Helvetica',
            fontSize: 16,
          )),
      onPressed: () => onPressed!(),
    );
  }

  Widget backButtom() {
    return Positioned(
      top: 30,
      left: 10,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.purple[200],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(Icons.arrow_back, size: 50 * 0.5, color: Colors.green),
          ),
        ),
      ),
    );
  }
}
