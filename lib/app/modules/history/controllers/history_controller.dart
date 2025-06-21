import 'package:get/get.dart';
import 'package:bycafe/app/modules/home/controllers/home_controller.dart';

class HistoryController extends GetxController {
  final HomeController homeController = Get.find();

  // Salin data dari HomeController ke variabel lokal agar bisa reactive
  var historyList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Sinkronisasi awal dari HomeController
    historyList.value = homeController.historyList;
  }

  void hapusRiwayat(int index) {
    if (index >= 0 && index < historyList.length) {
      historyList.removeAt(index);
      homeController.historyList.removeAt(index); // Sync ke HomeController
    }
  }

  void hapusSemuaRiwayat() {
    historyList.clear();
    homeController.historyList.clear(); // Sync ke HomeController
  }
}
