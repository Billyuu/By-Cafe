import 'package:get/get.dart';
import 'package:bycafe/app/routes/app_pages.dart';
import 'package:bycafe/app/modules/login/controllers/login_controller.dart';


class SplashScreenController extends GetxController {
final LoginController authC = Get.find<LoginController>();

//   @override
//   void onInit() {
//     super.onInit();
//     navigateToNextPage();
//   }

//   void navigateToNextPage() async {
//     await Future.delayed(Duration(seconds: 3)); // Tampilkan splash selama 3 detik

//     // Cek status autentikasi pengguna
//     User? user = authC.streamAuthStatus.value; // Ambil nilai dari stream

//     if (user != null && user.emailVerified) {
//       // Jika pengguna terautentikasi dan email terverifikasi
//       Get.offAllNamed(Routes.HOME);
//     } else {
//       // Jika pengguna belum terautentikasi atau email belum terverifikasi
//       Get.offAllNamed(Routes.LOGIN);
//     }
//   }
// }

// extension on Stream<User?> {
//   User? get value => null;
}







  // //TODO: Implement SplashScreenController

  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;
// }
