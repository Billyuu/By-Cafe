import 'package:get/get.dart';

import '../modules/add_penjualan/bindings/add_penjualan_binding.dart';
import '../modules/add_penjualan/views/add_penjualan_view.dart';
import '../modules/detail_pemesanan/bindings/detail_pemesanan_binding.dart';
import '../modules/detail_pemesanan/views/detail_pemesanan_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/menu_penjualan/bindings/menu_penjualan_binding.dart';
import '../modules/menu_penjualan/views/menu_penjualan_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';
import '../modules/update/bindings/update_binding.dart';
import '../modules/update/views/update_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PEMESANAN,
      page: () => const DetailPemesananView(),
      binding: DetailPemesananBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PENJUALAN,
      page: () => AddPenjualanView(),
      binding: AddPenjualanBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.MENU_PENJUALAN,
      page: () => MenuPenjualanView(),
      binding: MenuPenjualanBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE,
      page: () => UpdateView(),
      binding: UpdateBinding(),
    ),
  ];
}
