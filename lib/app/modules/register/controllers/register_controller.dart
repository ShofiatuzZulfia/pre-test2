import 'package:firebase_auth/firebase_auth.dart';
import 'package:pretest2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  var obscureText = true.obs;

  void togglePasswordView() {
    obscureText.value = !obscureText.value;
  }

  void register(String username, String email, String password,
      String confirmPassword) async {
    // Validasi input
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar(
        'Error',
        'All fields are required.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
      return; // Keluarkan dari fungsi jika ada input yang kosong
    }

    // Validasi password
    if (password != confirmPassword) {
      Get.snackbar(
        'Error',
        'Passwords do not match.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
      return; // Keluarkan dari fungsi jika password tidak cocok
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        'Success',
        'User created successfully',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(12),
      );
      userCredential.user!.sendEmailVerification();
      Get.defaultDialog(
          title: 'Verify your email',
          middleText:
              'Please verify your email to continue. We have sent you an email verification link.',
          textConfirm: 'OK',
          textCancel: 'Resend',
          confirmTextColor: Colors.white,
          onConfirm: () {
            Get.offAllNamed(Routes.LOGIN);
          },
          onCancel: () {
            userCredential.user!.sendEmailVerification();
            Get.snackbar(
              'Success',
              'Email verification link sent',
              snackPosition: SnackPosition.BOTTOM,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(12),
            );
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          'Error',
          'The password provided is too weak.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(12),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Error',
          'The account already exists for that email.',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 2),
          margin: EdgeInsets.all(12),
        );
      }
      print(e.code);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
