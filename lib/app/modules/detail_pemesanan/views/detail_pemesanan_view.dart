import 'package:bycafe/app/modules/printer/controllers/printer_controller.dart';
import 'package:bycafe/app/modules/service/settings_service.dart';
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
                        final homeController = controller.homeController;

                        final pesananSaatIni = List<Map<String, dynamic>>.from(
                          homeController.pesananList,
                        );
                        final total = controller.totalBayar.value;
                        final waktu = DateTime.now();

                        // Simpan ke history
                        homeController.historyList.add({
                          'pesanan': pesananSaatIni,
                          'total': total,
                          'tanggal': waktu.toIso8601String(),
                        });

                        // Ambil printer service
                        final printerController = Get.find<PrinterController>();
                        final printerService = printerController.printerService;

                        if (printerService.isConnected.value) {
                          // Ambil nilai PPN & Diskon dari SettingsService
                          final settings = Get.find<SettingsService>();
                          final ppn = settings.ppn.value;
                          final discount = settings.discount.value;

                          // Hitung ulang total jika perlu (opsional)
                          final subtotal = total / ((1 - discount) * (1 + ppn));

                          // Ubah format pesanan agar cocok dengan printReceipt()
                          final List<Map<String, dynamic>> formattedItems =
                              pesananSaatIni.map((item) {
                            return {
                              'name': item['nama'] ?? 'Item',
                              'quantity': item['jumlah'] ?? 1,
                              'price': item['totalHarga'] ??
                                  0, // Asumsinya total per item
                            };
                          }).toList();

                          // Cetak struk
                          printerService.printReceipt({
                            'items': formattedItems,
                            'subtotal': subtotal,
                            'discount_percentage': discount,
                            'ppn_percentage': ppn,
                            'total_amount': total,
                          });
                        } else {
                          Get.snackbar(
                            'Printer tidak terhubung',
                            'Harap hubungkan printer terlebih dahulu',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                          );
                          return;
                        }

                        // Reset pesanan
                        homeController.pesananList.clear();
                        homeController.totalItem.value = 0;
                        homeController.totalBayar.value = 0;

                        // Notifikasi sukses & navigasi
                        Get.snackbar(
                          'Berhasil',
                          'Pesanan telah dibayar dan dicetak',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );

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
