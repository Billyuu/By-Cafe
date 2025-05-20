import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPenjualanController extends GetxController {
// Mendefinisikan kelas CreateController yang meng-extend GetxController dari GetX.
// Kelas ini akan mengelola logika dan state untuk fitur yang terkait dengan penambahan dan pengambilan data di Firestore.

  var selectedIcon = ''.obs;
  // Variabel reaktif untuk menyimpan ikon yang dipilih, akan diobservasi oleh GetX.

  var titleController = TextEditingController();
  var momentsController = TextEditingController();
  // Controller untuk mengelola teks input dari pengguna untuk judul dan momen.

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // Instance FirebaseFirestore untuk berinteraksi dengan database Firestore.

  var notesList = <Map<String, dynamic>>[].obs;
  // List reaktif untuk menampung data catatan yang diambil dari Firestore.
  // Setiap kali data diperbarui di Firestore, list ini juga akan diperbarui.

  // Add new note to Firestore
  void addData(String nama, String harga) async {
    if (selectedIcon.value.isNotEmpty &&
        nama.isNotEmpty &&
        harga.isNotEmpty) {
      // Memeriksa apakah semua input (ikon, judul, momen) telah diisi.
      try {
        // Add note to Firestore (using 'data' collection)
        await firestore.collection('data').add({
          // 'icon': selectedIcon.value,
          'Nama': nama,
          'Harga': harga ,
          'createdAt': FieldValue.serverTimestamp(), // Optional timestamp
        });
        // Menambahkan catatan baru ke koleksi 'data' di Firestore dengan field ikon, judul, momen, dan waktu pembuatan.
        titleController.clear();
        momentsController.clear();
        selectedIcon.value = '';
        // Mengosongkan input setelah catatan berhasil ditambahkan.
        Get.snackbar("Success", "Note added successfully.",
            snackPosition: SnackPosition.BOTTOM);
        // Menampilkan snackbar pesan sukses di bagian bawah layar.
      } catch (e) {
        Get.snackbar("Error", "Failed to add note: $e",
            snackPosition: SnackPosition.BOTTOM);
        // Menampilkan snackbar pesan kesalahan jika terjadi kegagalan saat menambah catatan.
      }
    } else {
      Get.snackbar("Error", "Please fill in all fields and select an icon.",
          snackPosition: SnackPosition.BOTTOM);
      // Menampilkan snackbar pesan kesalahan jika ada input yang kosong.
    }
  }

  void fetchNotes() {
    firestore.collection('data').snapshots().listen((querySnapshot) {
      // Mengambil data dari koleksi 'data' di Firestore secara real-time.
      // Setiap perubahan di Firestore akan otomatis memicu pembaruan list.

      notesList.value = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          // 'icon': doc['icon'],
          'nama': doc['nama'],
          'harga': doc['harga'],
        };
      }).toList();
      // Mengubah data Firestore ke dalam bentuk list map dan memperbarui notesList.
    });
  }
}
