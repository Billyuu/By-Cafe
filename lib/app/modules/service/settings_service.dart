import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsService extends GetxService {
  final _box = GetStorage();
  final _ppnKey = 'ppn';
  final _discountKey = 'discount';

  // ✅ Nilai default: PPN 11%, Diskon 0%
  RxDouble get ppn => (_box.read<double>(_ppnKey) ?? 0.11).obs;
  RxDouble get discount => (_box.read<double>(_discountKey) ?? 0.0).obs;

  /// ✅ Simpan perubahan ke penyimpanan lokal & update reactive state
  Future<void> saveSettings({
    required double newPpn,
    required double newDiscount,
  }) async {
    await _box.write(_ppnKey, newPpn);
    await _box.write(_discountKey, newDiscount);
    ppn.value = newPpn;
    discount.value = newDiscount;
    Get.snackbar('Sukses', 'Pengaturan berhasil disimpan.');
  }
}
