import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_penjualan_controller.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';

class AddPenjualanView extends GetView<AddPenjualanController> {
  const AddPenjualanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff303030),
        title: const Text(
          'Tambahkan Produk Penjualan',
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
      backgroundColor: Colors.white,
      body: const Center(
        child: Text(
          'produk',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
