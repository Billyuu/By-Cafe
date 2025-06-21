import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: const Color(0xff303030),
  title: const Text(
    'History',
    style: TextStyle(fontFamily: 'calfont', color: Colors.white),
  ),
  leading: IconButton(
    icon: const Icon(Iconsax.arrow_left_2_copy, color: Colors.white),
    onPressed: () {
      Get.back();
    },
  ),
  actions: [
    IconButton(
      icon: const Icon(Icons.delete_forever, color: Colors.white),
      tooltip: 'Hapus Semua Riwayat',
      onPressed: () {
        if (controller.historyList.isEmpty) {
          Get.snackbar(
            'Kosong',
            'Tidak ada riwayat untuk dihapus',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white,
          );
          return;
        }

        Get.defaultDialog(
          title: 'Hapus Semua?',
          middleText: 'Yakin ingin menghapus semua riwayat?',
          textCancel: 'Batal',
          textConfirm: 'Hapus',
          confirmTextColor: Colors.white,
          onConfirm: () {
            controller.hapusSemuaRiwayat();
            Get.back();
            Get.snackbar(
              'Berhasil',
              'Semua riwayat telah dihapus',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          },
        );
      },
    ),
  ],
  centerTitle: true,
),

      body: ListView.builder(
  itemCount: controller.historyList.length,
  itemBuilder: (context, index) {
    final history = controller.historyList[index];
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text('Total: Rp ${history['total']}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tanggal: ${history['tanggal']}'),
            const SizedBox(height: 4),
            ...List.generate(history['pesanan'].length, (i) {
              final item = history['pesanan'][i];
              return Text(
                '${item['jumlah']} x ${item['nama']} - Rp ${item['totalHarga']}',
              );
            }),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: () {
                  Get.defaultDialog(
                    title: "Hapus Riwayat",
                    middleText: "Yakin ingin menghapus riwayat ini?",
                    textCancel: "Batal",
                    textConfirm: "Hapus",
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      controller.historyList.removeAt(index);
                      Get.back();
                      Get.snackbar(
                        'Berhasil',
                        'Riwayat berhasil dihapus',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    },
                  );
                },
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text(
                  'Hapus',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            )
          ],
        ),
      ),
    );
  },
),

    );
  }
}
