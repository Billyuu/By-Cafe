import 'package:bycafe/app/modules/service/printer_service.dart';
import 'package:bycafe/app/modules/service/settings_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/routes/app_pages.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/printer/controllers/printer_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // ✅ Daftarkan service dulu sebelum controller yang menggunakannya
  Get.put(PrinterService());
  Get.put(SettingsService()); // (opsional, kalau kamu pakai diskon & ppn)

  Get.put(HomeController(), permanent: true);
  Get.put(PrinterController(), permanent: true);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "By Cafe",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
