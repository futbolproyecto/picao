import 'package:flutter/material.dart';

class UiTextFiel {
  Widget textField({
    required String labelText,
    required IconData prefixIcon,
    required Color colorPrefixIcon,
    IconData? suffixIcon,
    Color? colorSuffixIcon,
    bool obscureText = false,
  }) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black54),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(prefixIcon, color: colorPrefixIcon),
        ),
        suffixIcon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(suffixIcon, color: colorSuffixIcon),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.black26, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Colors.black12),
        ),
      ),
    );
  }
}
