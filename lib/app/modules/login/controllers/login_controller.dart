import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final auth = FirebaseAuth.instance;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isPasswordVisible = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  // Stream status login/logout
  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  // Fungsi untuk login dengan email dan password
  void login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null && userCredential.user!.emailVerified) {
        Get.snackbar('Berhasil', 'Login sukses');
        Get.offAllNamed(Routes.HOME);
      } else {
        await auth.signOut();
        Get.snackbar('Verifikasi', 'Silakan verifikasi email Anda terlebih dahulu');
      }
    } on FirebaseAuthException {
      Get.snackbar('Login Gagal', 'Periksa kembali email dan password Anda');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
