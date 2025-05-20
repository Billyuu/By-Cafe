import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateController extends GetxController {
  final titleController = TextEditingController(); 
  final momentsController = TextEditingController(); 
  final selectedIcon = RxString('😊');

  final FirebaseFirestore firestore = FirebaseFirestore.instance; // Instance Firestore untuk berinteraksi dengan database
  var arg = Get.arguments[0]; // Menerima argumen pertama (ID dokumen) dari navigasi sebelumnya
  var judul = Get.arguments[1]; 
  var moment = Get.arguments[2]; 

  var title = ''.obs; // Variabel reaktif untuk judul
  var momentText = ''.obs; 
  var isTitle = false.obs; 

  // Fungsi untuk mengambil data dari Firestore berdasarkan docID
  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    try {
      DocumentSnapshot snapshot = await firestore.collection('data').doc(docID).get(); // Mengambil dokumen berdasarkan docID
      if (!snapshot.exists) {
        throw Exception('Document not found'); // Jika dokumen tidak ditemukan, lempar pengecualian
      }
      return snapshot; // Mengembalikan snapshot dokumen
    } catch (e) {
      print('Error fetching document: $e'); // Menampilkan pesan kesalahan jika ada error
      throw e; // Melemparkan pengecualian kembali agar bisa ditangani di tampilan
    }
  }

  // Fungsi untuk memperbarui data di Firestore dengan judul, momen, dan ikon yang dipilih
  Future<void> updateData(String docID, String title, String moments) async {
    try {
      await firestore.collection('data').doc(docID).update({
        'title': title, // Memperbarui judul di Firestore
        'Moments': moments,
        'icon': selectedIcon.value, 
      });
      Get.back(); // Kembali ke halaman sebelumnya
      Get.snackbar('Success', 'Data updated successfully'); 
    } catch (e) {
      print('Error updating data: $e'); // Menampilkan pesan kesalahan jika gagal memperbarui data
      Get.snackbar('Error', 'Failed to update data'); 
    }
  }

  // Fungsi untuk mengatur ikon yang dipilih
  void setIcon(String icon) {
    selectedIcon.value = icon; // Mengupdate nilai ikon yang dipilih
  }
}
