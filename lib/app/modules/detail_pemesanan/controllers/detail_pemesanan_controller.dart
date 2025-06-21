import 'package:get/get.dart';
import 'package:bycafe/app/modules/home/controllers/home_controller.dart';

class DetailPemesananController extends GetxController {
  final homeController = Get.find<HomeController>();

  // Getter untuk akses data dari HomeController
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
  }

  /// Simpan pesanan ke history, lalu reset data pesanan
  void bayarPesanan() {
  final pesananSaatIni = List<Map<String, dynamic>>.from(homeController.pesananList);
  final total = totalBayar.value;
  final waktu = DateTime.now();

  homeController.historyList.add({
    'pesanan': pesananSaatIni,
    'total': total,
    'tanggal': waktu.toString(),
  });

  homeController.pesananList.clear();
  homeController.totalItem.value = 0;
  homeController.totalBayar.value = 0;
}

}
