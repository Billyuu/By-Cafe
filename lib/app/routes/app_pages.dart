import 'package:get/get.dart';

import '../modules/add_penjualan/bindings/add_penjualan_binding.dart';
import '../modules/add_penjualan/views/add_penjualan_view.dart';
import '../modules/detail_pemesanan/bindings/detail_pemesanan_binding.dart';
import '../modules/detail_pemesanan/views/detail_pemesanan_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PEMESANAN,
      page: () => const DetailPemesananView(),
      binding: DetailPemesananBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PENJUALAN,
      page: () => const AddPenjualanView(),
      binding: AddPenjualanBinding(),
    ),
  ];
}
