import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:picao/modules/user/controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () {
                      controller.login(
                        usernameController.text,
                        passwordController.text,
                      );
                    },
                    child: const Text('Login'),
                  )),
          ],
        ),
      ),
    );
  }
}
