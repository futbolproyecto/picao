import 'package:flutter/material.dart';
import 'package:picao/core/constants/constants.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Constants.primaryColor),
      body: const Center(child: Text('Cambio clave')),
    );
  }
}
