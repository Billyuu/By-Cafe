import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  // Variabel untuk slider
  final isKeyboardVisible = false.obs;
  final textFocus = FocusNode();
  var currentIndex = 0.obs;

  var imageList = [
    {
      'image': 'assets/background.jpg',
      'text': "We'll be back",
      'text2': 'we promised.',
      'logo': 'assets/mocacino.png'
    },
    {
      'image': 'assets/background3.jpg',
      'text': 'Our Coffee',
      'text2': 'Our Fun.',
      'logo': 'assets/goodday.png'
    },
    {
      'image': 'assets/background4.jpg',
      'text': 'Story About ',
      'text2': 'Cup Of Coffee!',
      'logo': 'assets/copi.png'
    },
  ];

  // Variabel untuk menyimpan user info
  var username = ''.obs;
  var email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUserData(); // Panggil saat controller pertama kali dijalankan
  }

  // Mengubah index page
  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  // Ambil data user dari Firebase Authentication dan Firestore
  void getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      email.value = user.email ?? '';

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      if (doc.exists && doc.data()!.containsKey('username')) {
        username.value = doc['username'];
      }
    }
  }
}
