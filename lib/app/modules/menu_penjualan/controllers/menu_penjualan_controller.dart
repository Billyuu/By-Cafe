import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuPenjualanController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var userData = {}.obs;
  // Variabel reaktif untuk menyimpan data pengguna

  //mengambil data
  Stream<QuerySnapshot<Object?>> streamData() {
    // Fungsi untuk mengambil data secara real-time dari koleksi 'data' di Firestore.
    CollectionReference data = firestore.collection(
        'data'); // Data akan diurutkan berdasarkan field 'createdAt' dan dikirimkan dalam bentuk stream.
    return data
        .orderBy('createdAt', descending: true)
        .snapshots(); // Stream ini akan mengirimkan pembaruan secara otomatis ketika data berubah.
  }

  // delete data from Firestore
  void deleteData(String docID) async {
    try {
      Get.defaultDialog(
        title: "Delete Post",
        middleText: "Are you sure you want to delete this post?",
        onConfirm: () async {
          await firestore.collection('data').doc(docID).delete();
          Get.back();
          Get.snackbar('Success', 'Data deleted successfully');
        },
        textConfirm: "Yes, I'm sure",
        textCancel: "No",
      );
    } catch (e) {
      Get.snackbar('Error', 'Cannot delete this post');
      print(e);
    }
  }
  // Fungsi untuk menghapus data dari Firestore berdasarkan ID dokumen (docID).
  // Sebelum menghapus, akan menampilkan dialog konfirmasi.
  // Jika konfirmasi diterima, data akan dihapus, dan snackbar sukses akan muncul.
  // Jika gagal, snackbar error akan ditampilkan.
}
