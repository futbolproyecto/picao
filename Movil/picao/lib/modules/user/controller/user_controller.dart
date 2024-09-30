import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:picao/data/repositories/user/user_repository.dart';
import 'package:picao/modules/user/models/user_model.dart';
import 'package:reactive_forms/reactive_forms.dart';

class UserController extends GetxController {
  final UserRepository userRepository;
  UserController({required this.userRepository});

  var isLoading = false.obs;
  var user = Rxn<UserRegisterModel>();
  var obscureText = true.obs;

  var formUserRegistrer = FormGroup({
    'names': FormControl<String>(
      validators: [Validators.required, Validators.maxLength(50)],
    ),
    'surnames': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'email': FormControl<String>(validators: [
      Validators.required,
      Validators.email,
      Validators.maxLength(50)
    ]),
    'password': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'password_confirmation': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'cell_phone': FormControl<String>(
        validators: [Validators.required, Validators.maxLength(50)]),
    'birthdate': FormControl<DateTime>(
        validators: [Validators.required, Validators.maxLength(50)]),
  }, validators: [
    const MustMatchValidator('password', 'password_confirmation', false)
  ]);

  Future<void> registerUser() async {
    isLoading.value = true;
    user.value = await userRepository
        .registerUser(UserRegisterModel.fromJson(formUserRegistrer.value));
    isLoading.value = false;

    if (user.value != null) {
      Get.snackbar('Success', 'Logged in successfully');
    } else {
      Get.snackbar('Error', 'Invalid username or password',
          backgroundColor: Colors.red);
    }
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
  }
}
