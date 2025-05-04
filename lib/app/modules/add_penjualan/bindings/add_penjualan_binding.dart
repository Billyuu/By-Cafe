import 'package:get/get.dart';

import '../controllers/add_penjualan_controller.dart';

class AddPenjualanBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPenjualanController>(
      () => AddPenjualanController(),
    );
  }
}
