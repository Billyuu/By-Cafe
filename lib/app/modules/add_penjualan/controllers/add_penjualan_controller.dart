import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AddPenjualanController extends GetxController {
  final namaController = TextEditingController();
  final hargaController = TextEditingController();

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  Rx<File?> selectedImage = Rx<File?>(null);

  var isUploading = false.obs;
  var uploadImageUrl = ''.obs;
  var isPicking = false;

  final cloudName = 'dvndkijbe2';
  final uploadPreset = 'bycare';

  // Fungsi untuk memilih gambar dari galeri
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
      isUploading(true);

      final url =
          Uri.parse('https://api.cloudinary.com/v1_1/dvndkjbe2/image/upload');
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'bycafe'
        ..files.add(await http.MultipartFile.fromPath('file', pickedFile.path));

      final response = await request.send();
      isUploading(false);

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = json.decode(responseData);
        uploadImageUrl.value = data['secure_url'];
        Get.snackbar('Sukses', 'Berhasil upload gambar!');
      } else {
        Get.snackbar('Error', 'Upload gagal: ${response.statusCode}');
        print('Upload failed: ${response.statusCode}');
      }
    } else {
      Get.snackbar("Info", "Tidak ada gambar yang dipilih");
    }
  }

  Future<void> pickAndUploadImage() async {
    //   var status = await Permission.storage.request();
    // if (!status.isGranted) {
    //   Get.snackbar('Permission Denied', 'Storage permission is required');
    //   return;
    // }

    if (isPicking) return;
    isPicking = true;

    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile == null) return;

      File imageFile = File(pickedFile.path);
      isUploading(true);

      final url =
          Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');
      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = uploadPreset
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      isUploading(false);

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = json.decode(responseData);
        uploadImageUrl.value = data['secure_url'];
        Get.snackbar('sukses', 'berhasil upload');
      } else {
        Get.snackbar('Error', 'upload gagal: ${response.statusCode}');
      }
    } catch (e) {
      isPicking = false;
      print('ERROR INI COY: $e');
    }
  }

  // Fungsi untuk menambahkan data produk
  Future<void> addData(String nama, String harga) async {
    if (nama.isEmpty || harga.isEmpty) {
      Get.snackbar("Error", "Nama dan harga harus diisi.");
      return;
    }

    try {
      // Konversi harga ke number
      final hargaNumber = num.tryParse(harga);
      if (hargaNumber == null) {
        Get.snackbar("Error", "Harga harus berupa angka.");
        return;
      }

      // try {
      //   // if (selectedImage.value != null) {
      //   //   imageUrl = await uploadImage(selectedImage.value!);
      //   // }

      await firestore.collection('data').add({
        'nama': nama,
        'harga': hargaNumber,
        'imageUrl': uploadImageUrl.value.isEmpty ? '' : uploadImageUrl.value,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Reset form
      namaController.clear();
      hargaController.clear();
      uploadImageUrl.value = '';

      Get.snackbar("Sukses", "Produk berhasil ditambahkan.");
      Get.back();
    } catch (e) {
      Get.snackbar("Error", "Gagal menambahkan produk: $e");
    }
  }
}
