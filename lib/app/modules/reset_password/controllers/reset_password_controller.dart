import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResetPasswordController extends GetxController {
  final emailController = TextEditingController();
  var isLoading = false.obs;  // Untuk menunjukkan proses loading saat reset password

  // Fungsi untuk mereset password
  void resetPassword() async {
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Email tidak boleh kosong');
      return;
    }

    // Validasi format email
    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar('Error', 'Format email tidak valid');
      return;
    }

    try {
      isLoading.value = true; // Mulai loading
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
      isLoading.value = false; // Stop loading
      Get.snackbar('Berhasil', 'Link reset password telah dikirim ke email Anda');
    } on FirebaseAuthException catch (e) {
      isLoading.value = false; // Stop loading
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'Tidak ada akun dengan email tersebut');
      } else {
        Get.snackbar('Error', 'Gagal mengirim link reset password');
      }
    } catch (e) {
      isLoading.value = false; // Stop loading
      Get.snackbar('Error', 'Terjadi kesalahan, coba lagi nanti');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
