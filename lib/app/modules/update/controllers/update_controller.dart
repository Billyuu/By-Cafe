import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateController extends GetxController {
  final namaController = TextEditingController();
  final hargaController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var docId = Get.arguments[0]; // ID dokumen 
  var namaAwal = Get.arguments[1]; // Nama awal
  var hargaAwal = Get.arguments[2]; // Harga awal

  var nama = ''.obs;
  var harga = ''.obs;

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    try {
      DocumentSnapshot snapshot = await firestore.collection('data').doc(docID).get();
      if (!snapshot.exists) {
        throw Exception('Dokumen tidak ditemukan');
      }
      return snapshot;
    } catch (e) {
      print('Gagal mengambil data: $e');
      throw e;
    }
  }

  // Update data ke Firestore
  Future<void> updateData(String docID, String nama, String harga) async {
    try {
      await firestore.collection('data').doc(docID).update({
        'nama': nama,
        'harga': harga,
      });

      Get.back();
      Get.snackbar('Sukses', 'Data berhasil diperbarui');
    } catch (e) {
      print('Gagal memperbarui data: $e');
      Get.snackbar('Error', 'Gagal memperbarui data');
    }
  }
}
