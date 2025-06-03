import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var userData = {}.obs;

  var searchText = ''.obs;


  List<QueryDocumentSnapshot> filterData(
      List<QueryDocumentSnapshot> originalData) {
    if (searchText.value.isEmpty) return originalData;
    return originalData.where((doc) {
      final nama = (doc['nama'] ?? '').toString().toLowerCase();
      return nama.contains(searchText.value.toLowerCase());
    }).toList();
  }

  // Stream untuk mengambil data dari Firestore
  Stream<QuerySnapshot<Object?>> streamData() {
    CollectionReference data = firestore.collection('data');
    return data.orderBy('createdAt', descending: true).snapshots();
  }

  // Untuk slider
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

  var username = ''.obs;
  var email = ''.obs;

  // Favorite logic
  var favoriteStatus = <bool>[].obs;

  void initFavorites(int length) {
    favoriteStatus.value = List.generate(length, (index) => false);
  }

  void toggleFavorite(int index) {
    favoriteStatus[index] = !favoriteStatus[index];
  }

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

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
