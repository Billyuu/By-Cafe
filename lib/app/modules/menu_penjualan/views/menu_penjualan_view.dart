import 'package:bycafe/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../controllers/menu_penjualan_controller.dart';

class MenuPenjualanView extends GetView<MenuPenjualanController> {
  const MenuPenjualanView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff303030),
          title: const Text(
            'Menu',
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
              icon: const Icon(
                Icons.add_box,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Get.toNamed(Routes.ADD_PENJUALAN);
              },
            ),
          ]),
      backgroundColor: Colors.white,
      body: const Center(
        child: Text(
          'halaman penjualan',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
// SizedBox(
//   height: 360,
//   child: GridView.builder(
//     scrollDirection: Axis.vertical,
//     itemCount: 10,
//     padding: const EdgeInsets.all(8),
//     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//       crossAxisCount: 2, // dua kolom
//       crossAxisSpacing: 12,
//       mainAxisSpacing: 12,
//       childAspectRatio: 3 / 2, // atur rasio lebar:tinggi
//     ),
//     itemBuilder: (context, index) {
//       return InkWell(
//         onTap: () {
//           // Aksi ketika kotak ditekan
//         },
//         child: Card(
//           elevation: 5,
//           color: Colors.white,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   height: 80,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: Colors.grey[300],
//                     image: const DecorationImage(
//                       image: AssetImage('assets/esteh.png'),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   'Es Teh',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xff303030),
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 const Text(
//                   'Stock: 100',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.black54,
//                   ),
//                 ),
//                 const Spacer(),
//                 const Text(
//                   'Rp. 4.000',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xff303030),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   ),
// ),
