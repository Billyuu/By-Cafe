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
        backgroundColor: const Color(0xff303030),
        title: const Text(
          'Printer',
          style: TextStyle(fontFamily: 'calfont', color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() => Column(
          children: [
            /// 🔄 Tombol scan dan disconnect
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.search),
                    label: Text(controller.isScanning.value ? 'Mencari...' : 'Scan Ulang'),
                    onPressed: controller.isScanning.value ? null : controller.scanBluetooth,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.bluetooth_disabled),
                    label: const Text('Putuskan'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                    ),
                    onPressed: controller.isConnected.value
                        ? () {
                            Get.defaultDialog(
                              title: "Putuskan Koneksi",
                              content: const Text("Apakah kamu yakin ingin memutuskan koneksi printer?"),
                              textCancel: "Batal",
                              textConfirm: "Putuskan",
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                Get.back();
                                controller.disconnect();
                              },
                            );
                          }
                        : null,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// 🟢 Status koneksi
            Text(
              controller.isConnected.value
                  ? 'Terhubung ke: ${controller.selectedPrinter.value}'
                  : 'Status: Tidak Terhubung',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: controller.isConnected.value ? Colors.green : Colors.red,
              ),
            ),

            /// ℹ️ Status Message
            const SizedBox(height: 8),
            Text(
              controller.statusMessage.value,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),

            const Divider(height: 30),

            /// 🔍 Daftar perangkat
            Expanded(
              child: controller.devices.isEmpty && !controller.isScanning.value
                  ? const Center(
                      child: Text(
                        'Tidak ada perangkat ditemukan.\nTekan Scan untuk mencari.',
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: controller.devices.length,
                      itemBuilder: (_, index) {
                        final device = controller.devices[index];
                        final isSelected = controller.selectedPrinter.value == device.macAdress;
                        return Card(
                          child: ListTile(
                            title: Text(device.name ?? 'Unknown'),
                            subtitle: Text(device.macAdress ?? '-'),
                            trailing: isSelected
                                ? const Icon(Icons.check_circle, color: Colors.green)
                                : ElevatedButton(
                                    onPressed: () => controller.connect(device.macAdress ?? ''),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff303030),
                                    ),
                                    child: const Text("Connect"),
                                  ),
                          ),
                        );
                      },
                    ),
            ),

            const Divider(),

            /// 🖨️ Tombol tes print
            Center(
              child: ElevatedButton.icon(
                onPressed: controller.isConnected.value ? controller.printTest : null,
                icon: const Icon(Icons.print),
                label: const Text("Print Test"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: controller.isConnected.value ? Colors.green : Colors.grey,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
