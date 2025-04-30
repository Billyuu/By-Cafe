import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_pemesanan_controller.dart';

class DetailPemesananView extends GetView<DetailPemesananController> {
  const DetailPemesananView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailPemesananView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailPemesananView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
