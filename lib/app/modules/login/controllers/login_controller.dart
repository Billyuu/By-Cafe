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

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user!.emailVerified) {
        Get.snackbar('Berhasil', 'Login sukses');
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.snackbar('Verifikasi', 'Silakan verifikasi email Anda terlebih dahulu');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Gagal', e.message ?? 'Terjadi kesalahan');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
