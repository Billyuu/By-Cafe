import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_penjualan_controller.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AddPenjualanView extends GetView<AddPenjualanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff303030),
        title: const Text(
          'Tambahkan Produk',
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
      body: Container(
        color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Describe how you're feeling now",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
        
              // Tombol dan Preview Gambar
              Obx(() {
                return Column(
                  children: [
                    controller.selectedImage.value != null
                        ? Image.file(
                            controller.selectedImage.value!,
                            height: 200,
                          )
                        : const Text("Belum ada gambar dipilih"),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: controller.pickImage,
                      icon: const Icon(Icons.image),
                      label: const Text("Pilih Gambar"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        
                      ),
                    ),
                  ],
                );
              }),
        
              const SizedBox(height: 20),
        
              // Input Nama
              TextField(
                controller: controller.namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.black),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
        
              // Input Harga
              TextField(
                controller: controller.hargaController,
                decoration: const InputDecoration(
                  labelText: 'Harga',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(color: Colors.black),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
        
              // Tombol Simpan
              ElevatedButton(
                onPressed: () {
                  controller.addData(
                    controller.namaController.text,
                    controller.hargaController.text,
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32.0),
                  ),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
