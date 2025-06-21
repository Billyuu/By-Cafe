import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../controllers/printer_controller.dart';

class PrinterView extends GetView<PrinterController> {
  const PrinterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff303030),
        title: const Text(
          'Printer',
          style: TextStyle(fontFamily: 'calfont', color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PrinterView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
