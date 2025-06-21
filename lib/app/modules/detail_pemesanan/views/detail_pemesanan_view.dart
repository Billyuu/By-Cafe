import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_pemesanan_controller.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';

class DetailPemesananView extends GetView<DetailPemesananController> {
  const DetailPemesananView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff303030),
        title: const Text(
          'Detail Pesanan',
          style: TextStyle(color: Colors.white),
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
      body: Column(
        children: [
          Container(
            height: 450,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Obx(() => Column(
                        children: controller.homeController.pesananList
                            .map((pesanan) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${pesanan['jumlah']} x ${pesanan['nama']}',
                                style: TextStyle(fontSize: 18),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'Rp ${pesanan['totalHarga']}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  IconButton(
                                    icon: const Icon(Iconsax.trash_copy),
                                    onPressed: () {
                                      Get.defaultDialog(
                                        title: "Konfirmasi",
                                        middleText:
                                            "Yakin ingin menghapus pesanan ini?",
                                        textCancel: "Batal",
                                        textConfirm: "Hapus",
                                        confirmTextColor: Colors.white,
                                        onConfirm: () {
                                          controller.homeController.pesananList
                                              .remove(pesanan);
                                          controller.homeController.totalItem
                                                  .value -=
                                              pesanan['jumlah'] as int;
                                          controller.homeController.totalBayar
                                                  .value -=
                                              pesanan['totalHarga'] as int;
                                          Get.back();
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          );
                        }).toList(),
                      ))
                ],
              ),
            ),
          ),
          Divider(
            thickness: 1.5,
            color: Colors.grey,
          ),
          Container(
            height: 300,
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Jumlah item',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${controller.homeController.totalItem.value}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Subtotal',
                        style: TextStyle(fontSize: 18),
                      ),
                      Obx(() => Text(
                            'Rp ${controller.homeController.totalBayar.value}',
                            style: const TextStyle(fontSize: 18),
                          ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Diskon',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Rp 0',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Tax',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Rp 0',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Obx(() => Text(
                            'Rp ${controller.totalBayar.value}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 70,
                    child: ElevatedButton(
                      onPressed: () {
                        final pesananSaatIni = List<Map<String, dynamic>>.from(
                          controller.homeController.pesananList,
                        );
                        final total = controller.totalBayar.value;
                        final waktu = DateTime.now();

                        // Simpan ke history
                        controller.homeController.historyList.add({
                          'pesanan': pesananSaatIni,
                          'total': total,
                          'tanggal': waktu.toIso8601String(),
                        });

                        // Reset pesanan
                        controller.homeController.pesananList.clear();
                        controller.homeController.totalItem.value = 0;
                        controller.homeController.totalBayar.value = 0;

                        // Tampilkan notifikasi
                        Get.snackbar(
                          'Berhasil',
                          'Pesanan telah dibayar dan disimpan ke history',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );

                        // Navigasi ke halaman home
                        Get.offAllNamed('/home');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff303030),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'BAYAR',
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
