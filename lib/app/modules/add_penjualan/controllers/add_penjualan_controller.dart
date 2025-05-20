import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPenjualanController extends GetxController {
  // Controller untuk input nama dan harga produk
  final namaController = TextEditingController(); // Nama produk
  final hargaController = TextEditingController(); // Harga produk

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Menambahkan data produk baru ke koleksi 'data'
  void addData(String nama, String harga) async {
    if (nama.isNotEmpty && harga.isNotEmpty) {
      try {
        await firestore.collection('data').add({
          'nama': nama, 
          'harga': harga,
          'createdAt': FieldValue.serverTimestamp(),
        });

        // Bersihkan form setelah submit
        namaController.clear();
        hargaController.clear();

        Get.snackbar(
          "Sukses",
          "Produk berhasil ditambahkan.",
          snackPosition: SnackPosition.BOTTOM,
        );
      } catch (e) {
        Get.snackbar(
          "Error",
          "Gagal menambahkan produk: $e",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        "Error",
        "Nama dan harga harus diisi.",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
