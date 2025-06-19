import 'package:get/get.dart';
import 'package:bycafe/app/modules/home/controllers/home_controller.dart';

class DetailPemesananController extends GetxController {
  final homeController = Get.find<HomeController>();

  // Getter supaya ambil data langsung dari HomeController
  List<Map<String, dynamic>> get pesananList => homeController.pesananList;
  RxInt get totalItem => homeController.totalItem;
  RxInt get totalBayar => homeController.totalBayar;

  void hapusPesanan(int index) {
    if (index >= 0 && index < pesananList.length) {
      final pesanan = pesananList[index];
      totalItem.value -= pesanan['jumlah'] as int;
      totalBayar.value -= pesanan['totalHarga'] as int;
      pesananList.removeAt(index);
    }
  //   void tambahPesanan(String nama, int quantity, int totalHarga) {
  //   homeController.tambahPesanan(nama, quantity, totalHarga);
  // }
  }
}

