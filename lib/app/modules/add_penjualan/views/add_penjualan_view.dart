import 'package:bycafe/app/modules/menu_penjualan/views/menu_penjualan_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_penjualan_controller.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:flutter/services.dart'; 

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Add Your Product Here Now",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                // Tombol Gambar
                Obx(() {
                  return Column(
                    children: [
                      controller.selectedImage.value != null
                          ? Image.file(
                              controller.selectedImage.value!,
                              height: 200,
                            )
                          : const Text("No Images Selected"),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: ElevatedButton.icon(
                          onPressed: controller.pickImage,
                          icon: const Icon(Icons.image),
                          label: const Text("Pilih Gambar"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }),

                const SizedBox(height: 20),

                // Input Nama
                TextField(
                  cursorColor: Colors.black,
                  controller: controller.namaController,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    labelStyle:
                        const TextStyle(color: Colors.black), // warna teks
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 2.5),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black), // teks input
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: 20),

                // Input Harga

                TextField(
                  cursorColor: Colors.black,
                  controller: controller.hargaController,
                  keyboardType: TextInputType.number, //keyboard angka
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                  ], // ⬅️ Membatasi input hanya angka
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 2.5,
                      ),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  textInputAction: TextInputAction.done,
                ),

                const SizedBox(height: 50),

                // Tombol Simpan
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addData(
                        controller.namaController.text,
                        controller.hargaController.text,
                      );
                      Get.off(() => MenuPenjualanView());
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
