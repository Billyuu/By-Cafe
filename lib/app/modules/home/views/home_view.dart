import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:bycafe/app/routes/app_pages.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final CarouselSliderController _controller = CarouselSliderController();
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff303030),
        title: Text(
          'ByCafe',
          style: TextStyle(fontFamily: 'pacifico', color: Colors.white),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Iconsax.menu_1_copy),
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 230,
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                color: const Color(0xff303030),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 35,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                          'assets/icon.png'),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'ByCafe',
                      style: TextStyle(
                        fontFamily: 'pacifico',
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: Text(
                        'davisabilissalimuyp@gmail.com',
                        style: const TextStyle(
                          fontFamily: 'calfont',
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Iconsax.shop_add_copy),
                      title: Text('Menu'),
                      onTap: () {
                        Get.toNamed(Routes.MENU_PENJUALAN);
                      },
                    ),
                    ListTile(
                      leading: Icon(Iconsax.printer_copy),
                      title: Text('Printer'),
                      onTap: () {
                        Get.toNamed(Routes.PRINTER);
                      },
                    ),
                    ListTile(
                      leading: Icon(Iconsax.timer_1_copy),
                      title: Text('History'),
                      onTap: () {
                        Get.toNamed(Routes.HISTORY);
                      },
                    ),
                    ListTile(
                      leading: Icon(Iconsax.setting_2_copy),
                      title: Text('Settings'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(Iconsax.logout_copy),
                      title: const Text('Logout'),
                      onTap: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          Get.offAllNamed(Routes.LOGIN);
                          Get.snackbar(
                              'Berhasil', 'Anda telah berhasil logout');
                        } catch (e) {
                          Get.snackbar(
                              'Error', 'Gagal logout. Coba lagi nanti.');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              //algoia firebase
              padding: const EdgeInsets.all(10),
              child: TextField(
                cursorColor: Color(0xff303030),
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Iconsax.search_favorite_copy,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 255, 255, 255),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: const Color(0xff303030)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        BorderSide(color: const Color(0xff303030), width: 2),
                  ),
                ),
                onChanged: (value) => controller.searchText.value = value,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height:
                            160, // Jangan terlalu besar agar tetap dalam scroll
                        autoPlay: true,
                        enlargeCenterPage: true,
                        viewportFraction: 0.7,
                        autoPlayInterval: const Duration(seconds: 3),
                        onPageChanged: (index, reason) =>
                            controller.onPageChanged(index),
                      ),
                      items: controller.imageList.map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 37, 37, 37),
                                ),
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Opacity(
                                      opacity: 0.2,
                                      child: Image.asset(
                                        item['image']!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 35),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item['text']!,
                                                  style: TextStyle(
                                                    fontFamily: 'calfont',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 10.0,
                                                        color: Colors.black,
                                                        offset:
                                                            Offset(2.0, 2.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(height: 3),
                                                Text(
                                                  item['text2']!,
                                                  style: TextStyle(
                                                    fontFamily: 'calfont',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    shadows: [
                                                      Shadow(
                                                        blurRadius: 10.0,
                                                        color: Colors.black,
                                                        offset:
                                                            Offset(2.0, 2.0),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Image.asset(
                                            item['logo']!,
                                            width: 110,
                                            height: 90,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Obx(() => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                              controller.imageList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 7.0,
                                height: 7.0,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: (Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? Colors.white
                                          : Colors.black)
                                      .withOpacity(
                                          controller.currentIndex == entry.key
                                              ? 0.9
                                              : 0.4),
                                ),
                              ),
                            );
                          }).toList(),
                        )),
                    SizedBox(height: 10),

                    //card
                    StreamBuilder<QuerySnapshot<Object?>>(
                      stream: controller.streamData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.active) {
                          if (snapshot.hasData &&
                              snapshot.data!.docs.isNotEmpty) {
                            final filtered =
                                controller.filterData(snapshot.data!.docs);

                            if (filtered.isEmpty) {
                              return const Center(
                                  child: Text('Tidak ada hasil pencarian'));
                            }

                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: filtered.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                                childAspectRatio: 7 / 8,
                              ),
                              itemBuilder: (context, index) {
                                final doc = filtered[index].data();
                                if (doc is! Map<String, dynamic>)
                                  return const SizedBox();

                                final nama = doc['nama'] ?? 'Tanpa Nama';
                                final harga = doc['harga'] ?? '0';
                                final imageUrl = doc['imageUrl'];

                                return GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: Colors.white,
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                      ),
                                      builder: (_) {
                                        final controller =
                                            Get.find<HomeController>();

                                        RxInt quantity = 1.obs;
                                        RxInt totalHarga = RxInt(harga);

                                        ever(quantity, (_) {
                                          totalHarga.value =
                                              harga * quantity.value;
                                        });

                                        return Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (imageUrl != null &&
                                                  imageUrl != '')
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.network(
                                                    imageUrl,
                                                    height: 220,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              const SizedBox(height: 12),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  /// Kiri: nama dan harga
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          nama,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 4),
                                                        Text(
                                                          'Harga: ${controller.formatRupiah(harga)}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  /// Kanan: tombol tambah/kurang + total harga di bawahnya
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          IconButton(
                                                            onPressed: () {
                                                              if (quantity
                                                                      .value >
                                                                  1)
                                                                quantity
                                                                    .value--;
                                                            },
                                                            icon: const Icon(
                                                                Icons
                                                                    .remove_circle,
                                                                color: Color(
                                                                    0xff303030),
                                                                size: 22),
                                                          ),
                                                          Obx(() => Text(
                                                                '${quantity.value}',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                              )),
                                                          IconButton(
                                                            onPressed: () {
                                                              quantity.value++;
                                                            },
                                                            icon: const Icon(
                                                                Icons
                                                                    .add_circle,
                                                                color: Color(
                                                                    0xff303030),
                                                                size: 22),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Obx(() => Text(
                                                            'Total: ${controller.formatRupiah(totalHarga.value)}',
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 20),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Color(0xff303030),
                                                      foregroundColor:
                                                          Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Tutup"),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Color(0xff303030),
                                                      foregroundColor:
                                                          Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      controller.tambahPesanan(
                                                          nama,
                                                          quantity.value,
                                                          totalHarga.value);

                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text("Simpan"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              if (imageUrl != null &&
                                                  imageUrl != '')
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    imageUrl,
                                                    height: 100,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        const Icon(
                                                            Icons.broken_image),
                                                  ),
                                                )
                                              else
                                                const SizedBox(
                                                  height: 100,
                                                  child: Center(
                                                    child: Icon(Icons
                                                        .image_not_supported),
                                                  ),
                                                ),
                                              Positioned(
                                                top: 5,
                                                right: 5,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(7),
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.white70,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons
                                                        .favorite_border_outlined,
                                                    size: 18,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            nama,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Rp. $harga',
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return const Center(child: Text('Tidak ada menu.'));
                          }
                        }

                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.white,
        child: Obx(() => ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.DETAIL_PEMESANAN);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff303030),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bayar Sekarang',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Text(
                    controller.formatRupiah(controller.totalBayar.value),
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '(${controller.totalItem.value} Item)',
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
