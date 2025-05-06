import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bycafe/app/routes/app_pages.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/splash.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.3),
          ),
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'ByCafe',
                style: TextStyle(
                  fontFamily: 'pacifico',
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      offset: Offset(3, 6),
                      blurRadius: 6,
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Feeling Low? Take a Sip Of Coffe',
                  style: TextStyle(
                    fontFamily: 'calfont',
                    fontSize: 20,
                    color: const Color.fromARGB(186, 255, 255, 255),
                  ),
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 165,
                  height: 65,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.toNamed(Routes.HOME);
                    },
                    label: Text(
                      'Get Started',
                      style: TextStyle(
                        fontFamily: 'calfont',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffe57734),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
