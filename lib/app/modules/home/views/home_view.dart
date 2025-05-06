import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:bycafe/app/routes/app_pages.dart';
// import 'package:bycafe/app/modules/detail_pemesanan/views/detail_pemesanan_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff303030),
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
                    leading: Icon(Iconsax.logout_copy),
                    title: Text('Lougout'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          physics: controller.isKeyboardVisible.value
              ? AlwaysScrollableScrollPhysics()
              : NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              TextField(
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
                    borderSide: BorderSide(
                        color: const Color(0xff303030)), // Saat tidak fokus
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                        color: const Color(0xff303030), width: 2), // Saat fokus
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 170,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    // Container 1
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: const Color(0xff303030),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: 0.2,
                                child: Image.asset(
                                  'assets/background.jpg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "We'll be back",
                                              style: TextStyle(
                                                fontFamily: 'calfont',
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "we promised.",
                                              style: TextStyle(
                                                fontFamily: 'calfont',
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        'assets/kopii.png',
                                        width: 170,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Container 2
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: const Color(0xff4a4a4a),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: 0.2,
                                child: Image.asset(
                                  'assets/background.jpg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Discover New",
                                              style: TextStyle(
                                                fontFamily: 'calfont',
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Coffee Moments",
                                              style: TextStyle(
                                                fontFamily: 'calfont',
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        'assets/kopii.png',
                                        width: 170,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Container 3
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        height: 170,
                        decoration: BoxDecoration(
                          color: const Color(0xff5c5c5c),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Stack(
                            children: [
                              Opacity(
                                opacity: 0.2,
                                child: Image.asset(
                                  'assets/background.jpg',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Text(
                                              "Your Daily",
                                              style: TextStyle(
                                                fontFamily: 'calfont',
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Coffee Dose",
                                              style: TextStyle(
                                                fontFamily: 'calfont',
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        'assets/kopii.png',
                                        width: 170,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 415,
                child: GridView.builder(
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Jumlah kolom
                  ),
                  itemBuilder: (context, index) {
                    // final item = controller.itemList[index];
                    // final imageKey = GlobalKey();

                    return InkWell(
                      onTap: () {
                        // controller.onItemTap(item);
                        // final imageBox = imageKey.currentContext!
                        //     .findRenderObject() as RenderBox;
                        // final bayarBox = bayarKey.currentContext!
                        //     .findRenderObject() as RenderBox;

                        // controller.startAnimation(
                        //   context: context,
                        //   imageBox: imageBox,
                        //   bayarBox: bayarBox,
                        // );
                      },
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
                                // width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Colors.grey[300],
                                  image: const DecorationImage(
                                    image: AssetImage('assets/esteh.png'),
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Es Teh',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff303030),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Rp. 4.000',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff303030),
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
              SizedBox(
                height: 05,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.DETAIL_PEMESANAN);
                },
                child: Container(
                  height: 60,
                  width: 400,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  decoration: BoxDecoration(
                    color: Color(0xff303030),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'BAYAR',
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      Text(
                        'Rp. 50.000 (1 item)',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
