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
                    title: Text('Penjualan'),
                    onTap: () {
                      Get.toNamed(Routes.ADD_PENJUALAN);
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
              Container(
                height: 170,
                decoration: BoxDecoration(
                  color: Color(0xff303030),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ClipRRect(
                  //agar gambar mengikuti radius
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    //Menyusun elemen secara bebas, misalnya teks di atas gambar, ikon di sudut layar, dll.
                    children: [
                      Opacity(
                        //agar transparan
                        opacity: 0.2,
                        child: Image.asset(
                          'assets/background.jpg',
                          fit: BoxFit
                              .cover, //mengisi gambar penuh tanpa merubah rasionya
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
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "We'll be back",
                                        style: TextStyle(
                                          fontFamily: 'pacifico',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "we promised.",
                                        style: TextStyle(
                                          fontFamily: 'pacifico',
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            //gambar di kanan
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
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 360,
                child: ListView.builder(
                  itemCount: 10,
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
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey[300],
                                  image: DecorationImage(
                                    image: AssetImage('assets/esteh.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Es Teh',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff303030),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Stock: 100',
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Rp. 4.000',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff303030),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // child: Card(
                      //   child: Padding(
                      //     padding:
                      //         const EdgeInsets.symmetric(horizontal: 10),
                      //     child: Row(
                      //       children: [
                      //         Image.network(
                      //           "https://i.pinimg.com/736x/cb/87/1e/cb871e4708cba30bbdc95b300abb9fab.jpg",
                      //           key: imageKey,
                      //           height: 50,
                      //         ),
                      //         Container(
                      //           padding: const EdgeInsets.only(left: 10),
                      //           width: 150,
                      //           child: Column(
                      //             crossAxisAlignment:
                      //                 CrossAxisAlignment.start,
                      //             children: [
                      //               Text(
                      //                 'Es Teh',
                      //                 style: TextStyle(fontSize: 17),
                      //               ),
                      //               Text(
                      //                 'Stock 100',
                      //                 style: TextStyle(fontSize: 14),
                      //               ),
                      //             ],
                      //           ),
                      //         ),
                      //         Text(
                      //           'Rp. 4.000',
                      //           style: TextStyle(fontSize: 16),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.DETAIL_PEMESANAN);
                },
                child: Container(
                  height: 100,
                  width: 400,
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Color(0xff303030),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'BAYAR',
                        style: TextStyle(fontSize: 19, color: Colors.white),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Rp. 50.000 (1 item)',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      )
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
