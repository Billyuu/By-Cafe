import 'package:get/get.dart';

import '../controllers/menu_penjualan_controller.dart';

class MenuPenjualanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MenuPenjualanController>(
      () => MenuPenjualanController(),
    );
  }
}
