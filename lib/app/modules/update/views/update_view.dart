import 'package:bycafe/app/modules/menu_penjualan/views/menu_penjualan_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/update_controller.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UpdateView extends GetView<UpdateController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff303030),
        title: const Text(
          'Update Produk',
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
                      "Update Your Product Here",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Gambar
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
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            controller.isUploading.value = true;
                            controller.pickImage();
                          },
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

                // Input Nama Produk
                TextFormField(
                  initialValue: controller.namaAwal,
                  decoration: InputDecoration(
                    labelText: 'Nama Produk',
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
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
                  style: const TextStyle(color: Colors.black),
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    controller.nama.value = value;
                  },
                ),

                const SizedBox(height: 20),

                // Input Harga Produk
                TextFormField(
                  initialValue: controller.hargaAwal,
                  decoration: InputDecoration(
                    labelText: 'Harga Produk',
                    labelStyle: const TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
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
                  style: const TextStyle(color: Colors.black),
                  textInputAction: TextInputAction.done,
                  onChanged: (value) {
                    controller.harga.value = value;
                  },
                ),

                const SizedBox(height: 40),

                // Tombol Simpan
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: controller.isUploading.value
                          ? null
                          : () async {
                              await controller.updateData(
                                controller.docId,
                                controller.nama.value,
                                controller.harga.value,
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
                        'Simpan Perubahan',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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
