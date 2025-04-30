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
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: Icon(Iconsax.menu_1_copy),
              color: Colors.white,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      endDrawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              color: Color(0xff303030),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Iconsax.profile_tick,
                      size: 30,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'ByCafe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Iconsax.home),
                    title: Text('Home'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Iconsax.setting_2),
                    title: Text('Settings'),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Iconsax.logout_1),
                    title: Text('Lougout'),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
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
                    //agar terlihat transparan
                    opacity: 0.2,
                    child: Image.network(
                      'https://st2.depositphotos.com/2791409/8121/i/450/depositphotos_81218166-stock-photo-coffee-backgrond.jpg',
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                        Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/coffe.PNG',
                                width: 120,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // SizedBox(
                            //     height: 5),
                            Text(
                              'Cappucino Latte',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'pacifico',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.DETAIL_PEMESANAN);
            },
            child: Container(
              height: 100,
              color: Colors.amber,
            ),
          ),
        ]),
      ),
    );
  }
}
