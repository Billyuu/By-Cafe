import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UpdateController extends GetxController {
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  Rx<File?> selectedImage = Rx<File?>(null);

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var docId = Get.arguments[0]; // ID dokumen
  var namaAwal = Get.arguments[1]; // Nama awal
  var hargaAwal = Get.arguments[2]; // Harga awal
  var pic = Get.arguments[3];

  var nama = ''.obs;
  var harga = ''.obs;

  var isUploading = false.obs;
  var uploadImageUrl = ''.obs;
  var isPicking = false;

  final cloudName = 'dvndkijbe2';
  final uploadPreset = 'bycare';

  Future<void> pickImage() async {
    // isUploading();
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);

      final url =
          Uri.parse('https://api.cloudinary.com/v1_1/dvndkjbe2/image/upload');
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'bycafe'
        ..files.add(await http.MultipartFile.fromPath('file', pickedFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = json.decode(responseData);
        uploadImageUrl.value = data['secure_url'];
        Get.snackbar('Sukses', 'Berhasil upload gambar!');
        isUploading(false);
      } else {
        Get.snackbar('Error', 'Upload gagal: ${response.statusCode}');
        print('Upload failed: ${response.statusCode}');
      }
    } else {
      Get.snackbar("Info", "Tidak ada gambar yang dipilih");
    }
  }

  Future<DocumentSnapshot<Object?>> getData(String docID) async {
    try {
      DocumentSnapshot snapshot =
          await firestore.collection('data').doc(docID).get();
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
  Future<void> updateData(String docID, String? nama, String? harga) async {
    try {
      await firestore.collection('data').doc(docID).update({
        'nama': nama == "" ? namaAwal : nama,
        'harga': harga == "" ? hargaAwal : harga,
        'imageUrl': uploadImageUrl.value.isEmpty
            ? pic
            : uploadImageUrl.value, // Kosong jika tidak ada gambar,
      });

      Get.back();
      Get.snackbar('Sukses', 'Data berhasil diperbarui');
    } catch (e) {
      print('Gagal memperbarui data: $e');
      Get.snackbar('Error', 'Gagal memperbarui data');
    }
  }
}
