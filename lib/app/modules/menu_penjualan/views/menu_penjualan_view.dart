import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                      2 / 3, // Lebar 3, tinggi 2 (bisa disesuaikan)
                ),
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var data2 = data[index].data() as Map<String, dynamic>?;

                  if (data2 != null &&
                      data2.containsKey('nama') &&
                      data2.containsKey('harga')) {
                    return Card(
                      color: Colors.white,
                      margin: EdgeInsets.zero,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // color: cardColor,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data2['imageUrl'] != null &&
                                data2['imageUrl'] != "")
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  data2['imageUrl'],
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                ),
                              )
                            else
                              const SizedBox(
                                height: 100,
                                child: Center(
                                  child: Icon(Icons.image_not_supported),
                                ),
                              ),
                            const SizedBox(height: 8),
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
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF4F4F4),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton.icon(
                                    onPressed: () => Get.toNamed(
                                      Routes.UPDATE,
                                      arguments: [
                                        data[index].id,
                                        data2['nama'],
                                        data2['harga'],
                                        data2['imageUrl'],
                                      ],
                                    ),
                                    icon: const Icon(Icons.edit,
                                        color: Colors.blue, size: 16), 
                                    label: const Text(
                                      'Edit',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12, 
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () =>
                                        controller.deleteData(data[index].id),
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red, size: 16), 
                                    label: const Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12, 
                                      ),
                                    ),
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 4),
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
