import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:bycafe/app/routes/app_pages.dart';
import 'package:carousel_slider/carousel_slider.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:bycafe/app/modules/detail_pemesanan/views/detail_pemesanan_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final CarouselSliderController _controller = CarouselSliderController();
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 29, 34, 65),
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
      backgroundColor: Color.fromARGB(255, 29, 34, 65),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 210,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              color: const Color(0xff303030),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Iconsax.profile_tick,
                      size: 30,
                    ),
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
                  SizedBox(height: 5),
                  Flexible(
                    child: Text(
                      'davisabilissalimuyp@gmail.com',
                      style: const TextStyle(
                        fontFamily: 'calfont',
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Tambahkan elipsis (...) jika terlalu panjang
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
                    leading: Icon(Iconsax.setting_2_copy),
                    title: Text('Settings'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Iconsax.logout_copy),
                    title: const Text('Logout'),
                    onTap: () async {
                      try {
                        // Melakukan logout
                        await FirebaseAuth.instance.signOut();
                        Get.offAllNamed(Routes.LOGIN);
                        Get.snackbar('Berhasil', 'Anda telah berhasil logout');
                      } catch (e) {
                        // Tangani error jika ada
                        Get.snackbar('Error', 'Gagal logout. Coba lagi nanti.');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
  children: [
    Column(
      children: [
        // SEARCH BAR TETAP DI ATAS
        Padding(
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
          ),
        ),

        // BAGIAN YANG BISA DI SCROLL (carousel + grid)
        Expanded(
          child: Obx(
            () => SingleChildScrollView(
              physics: controller.isKeyboardVisible.value
                  ? AlwaysScrollableScrollPhysics()
                  : BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 160,
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
                                                        offset: Offset(2.0, 2.0),
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
                                                        offset: Offset(2.0, 2.0),
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
                          children: controller.imageList
                              .asMap()
                              .entries
                              .map((entry) {
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
                                      .withOpacity(controller.currentIndex ==
                                              entry.key
                                          ? 0.9
                                          : 0.4),
                                ),
                              ),
                            );
                          }).toList(),
                        )),

                    SizedBox(height: 10),

                    SizedBox(
                      // height: 2000,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 20,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 80,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: Colors.grey[300],
                                        image: const DecorationImage(
                                          image: AssetImage('assets/esteh.png'),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      'Es Teh',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      'Rp. 4.000',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 100), // ruang bawah agar tidak tertutup tombol
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),

    // Posisi tombol bayar tetap di bawah layar
    Positioned(
      bottom: 5,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.DETAIL_PEMESANAN);
          },
          child: Container(
            height: 55,
            width: 350,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 50),
            decoration: BoxDecoration(
              color: Color(0xff1a237e),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'BAYAR',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
                Text(
                  'Rp. 50.000 (1 item)',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    ),

        ],
      ),
    );
  }
}
