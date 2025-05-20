import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // 🔥 Tambahkan ini
import 'package:bycafe/app/routes/app_pages.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../controllers/menu_penjualan_controller.dart';

class MenuPenjualanView extends GetView<MenuPenjualanController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff303030),
        title: const Text(
          'Menu Penjualan',
          style: TextStyle(fontFamily: 'calfont', color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Iconsax.arrow_left_2_copy, color: Colors.white),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Iconsax.add_square_copy, color: Colors.white),
            iconSize: 30,
            onPressed: () {
              Get.toNamed(Routes.ADD_PENJUALAN);
            },
            tooltip: 'Tambah Produk',
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              var data = snapshot.data!.docs;

              return GridView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio:
                      3 / 3, // Lebar 3, tinggi 2 (bisa disesuaikan)
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var data2 = data[index].data() as Map<String, dynamic>?;

                  if (data2 != null &&
                      data2.containsKey('title') &&
                      data2.containsKey('moment')) {
                    Color cardColor = Colors.blue[100]!;

                    switch (data2['icon']) {
                      case '😊':
                        cardColor = Colors.green[100]!;
                        break;
                      case '😡':
                        cardColor = Colors.red[100]!;
                        break;
                      case '😐':
                        cardColor = Colors.grey[100]!;
                        break;
                      default:
                        cardColor = Colors.blue[100]!;
                    }

                    return Card(
                      margin: EdgeInsets.zero,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(
                            //   data2['icon'] ?? '😊',
                            //   style: const TextStyle(fontSize: 28),
                            // ),
                            // const SizedBox(height: 6),
                            Text(
                              "Nama: ${data2['nama']}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Harga: ${data2['harga']}',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () => Get.toNamed(
                                    Routes.UPDATE,
                                    arguments: [
                                      data[index].id,
                                      data2['title'],
                                      data2['moment'],
                                    ],
                                  ),
                                  icon: const Icon(Icons.edit,
                                      color: Colors.blue),
                                  tooltip: 'Update',
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      controller.deleteData(data[index].id),
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  tooltip: 'Delete',
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              );
            } else {
              return const Center(
                child: Text('No data',
                    style: TextStyle(color: Colors.blue, fontSize: 18)),
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
