import 'dart:developer';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:intl/intl.dart';
// Jika Anda sebelumnya memiliki import untuk ByteData atau image/image, pastikan tetap ada jika digunakan di printTest
// import 'package:flutter/services.dart';
// import 'package:image/image.dart' as im;

class PrinterService extends GetxService {
  final isConnected = false.obs;
  final macAddress = ''.obs;
  final availableDevices = <BluetoothInfo>[].obs;
  final isScanning = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Anda bisa memanggil _getSavedPrinter() di sini jika ingin otomatis connect
    // _getSavedPrinter();
  }

  // Metode untuk meminta izin Bluetooth dan Lokasi
  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.locationWhenInUse, // Dibutuhkan untuk Bluetooth di Android 12+
    ].request();

    bool allGranted = statuses.values.every((status) => status.isGranted);
    if (!allGranted) {
      Get.snackbar('Izin Diperlukan', 'Harap berikan semua izin Bluetooth dan Lokasi untuk melanjutkan.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
          colorText: Get.theme.colorScheme.onError);
    }
    return allGranted;
  }

  Future<void> scanDevices() async {
    if (!await requestPermissions()) {
      return; // Berhenti jika izin tidak diberikan
    }

    try {
      isScanning.value = true;
      availableDevices.clear(); // Bersihkan daftar sebelum scan baru

      final List<BluetoothInfo> devices = await PrintBluetoothThermal.pairedBluetooths;
      availableDevices.assignAll(devices);
      for (var d in devices) {
        log("🖨️ Ditemukan: ${d.name} - ${d.macAdress}");
      }
      if (devices.isEmpty) {
        Get.snackbar('Info', 'Tidak ada perangkat Bluetooth ditemukan. Pastikan Bluetooth aktif.',
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar('Berhasil', '${devices.length} perangkat ditemukan.',
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      log("❌ Scan Error: $e");
      Get.snackbar('Error', 'Scan gagal: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
          colorText: Get.theme.colorScheme.onError);
    } finally {
      isScanning.value = false;
    }
  }

  Future<void> connect(String mac) async {
    if (mac.isEmpty) {
      Get.snackbar('Info', 'Alamat MAC printer tidak valid.', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (!await requestPermissions()) {
      return; // Berhenti jika izin tidak diberikan
    }

    try {
      log("🔌 Menghubungkan ke: $mac");
      // Parameter macPrinterAddress sudah benar untuk versi 1.1.6
      final result = await PrintBluetoothThermal.connect(macPrinterAddress: mac); 
      log("📡 Status koneksi: $result"); // Ini akan logging "true" atau "false"

      isConnected.value = result;
      if (result) {
        macAddress.value = mac;
        Get.snackbar('Berhasil', 'Terhubung ke printer $mac');
        // Anda bisa menambahkan GetStorage().write('saved_mac', mac); di sini jika diinginkan
      } else {
        Get.snackbar('Gagal', 'Tidak dapat terhubung ke printer. Pastikan printer menyala dan dalam jangkauan.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
            colorText: Get.theme.colorScheme.onError);
      }
    } catch (e) {
      log("❌ Error connect: $e");
      Get.snackbar('Error', 'Gagal menghubungkan: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
          colorText: Get.theme.colorScheme.onError);
    }
  }

  Future<void> disconnect() async {
    try {
      await PrintBluetoothThermal.disconnect;
      isConnected.value = false;
      macAddress.value = '';
      availableDevices.refresh(); // Mungkin tidak perlu jika devices tidak berubah setelah disconnect
      Get.snackbar('Putus', 'Koneksi printer diputus.');
      // Hapus MAC address yang disimpan di sini jika Anda menggunakan GetStorage
      // await GetStorage().remove('saved_mac');
    } catch (e) {
      log("❌ Gagal disconnect: $e");
      Get.snackbar('Error', 'Gagal memutuskan koneksi: ${e.toString()}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
          colorText: Get.theme.colorScheme.onError);
    }
  }

  // Di dalam PrinterService.dart

Future<void> printTest() async {
  // PENTING: Periksa status koneksi menggunakan nilai RxBool isConnected
  // yang seharusnya sudah diperbarui oleh metode connect()
  if (!isConnected.value) { // Menggunakan isConnected.value yang RxBool
    Get.snackbar('Gagal', 'Printer tidak terhubung. Harap sambungkan terlebih dahulu.', snackPosition: SnackPosition.BOTTOM);
    return;
  }

  // Jika Anda tetap ingin memeriksa status dari library, lakukan dengan lebih aman.
  // Namun, utamakan isConnected.value yang dikelola oleh GetX.
  final rawStatus = await PrintBluetoothThermal.connectionStatus;
  if (rawStatus != "true") {
      log("Status koneksi dari library: $rawStatus. Memperbarui isConnected.value ke false.");
      isConnected.value = false; // Sinkronkan status RxBool
      Get.snackbar('Gagal', 'Printer terputus. Harap sambungkan kembali.', snackPosition: SnackPosition.BOTTOM);
      return;
  }


  try {
    const text = "BY CAFE\nTes Print Berhasil\n----------------\n\n\n";
    final result = await PrintBluetoothThermal.writeString(
      printText: PrintTextSize(size: 1, text: text),
    );

    if (result) {
      Get.snackbar("Sukses", "Tes print berhasil.");
    } else {
      Get.snackbar("Gagal", "Tes print gagal. Periksa koneksi printer atau coba lagi.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
          colorText: Get.theme.colorScheme.onError);
    }
  } catch (e) {
    log("❌ Gagal cetak tes: $e");
    Get.snackbar("Error", "Gagal cetak tes: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
        colorText: Get.theme.colorScheme.onError);
  }
}

  Future<void> printReceipt(Map<String, dynamic> data) async {
    if (!isConnected.value) {
      Get.snackbar('Error', 'Printer belum terhubung!', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    try {
      final currency = NumberFormat("#,##0", "id_ID");
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);
      List<int> bytes = [];

      bytes += generator.text("BY CAFE",
          styles: const PosStyles(bold: true, align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size2)); // Ukuran teks header
      bytes += generator.text("Jl. Raya Teknologi No. 123",
          styles: const PosStyles(align: PosAlign.center));
      bytes += generator.text("Telp: 081234567890",
          styles: const PosStyles(align: PosAlign.center));
      bytes += generator.hr(); // Horizontal Rule

      // Loop untuk setiap item
      if (data.containsKey('items') && data['items'] is List) {
        bytes += generator.text('ITEM                 QTY   HARGA    TOTAL'); // Header tabel
        bytes += generator.hr();
        for (var item in data['items']) {
          final name = item['name']?.toString() ?? '-';
          // Pastikan kuantitas adalah int
          final quantity = int.tryParse(item['quantity']?.toString() ?? '0') ?? 0;
          // Pastikan harga adalah double
          final price = double.tryParse(item['price']?.toString() ?? '0.0') ?? 0.0;
          
          final itemTotal = quantity * price; // Hasilnya akan double karena 'price' adalah double

          bytes += generator.row([
            PosColumn(
              text: name.length > 15 ? '${name.substring(0, 12)}...' : name.padRight(15), // Potong jika terlalu panjang
              width: 5, // Sesuaikan lebar kolom
              styles: const PosStyles(align: PosAlign.left),
            ),
            PosColumn(
              text: quantity.toString().padLeft(3),
              width: 2, // Sesuaikan lebar kolom
              styles: const PosStyles(align: PosAlign.right),
            ),
            PosColumn(
              text: currency.format(price).padLeft(7), // Harga satuan
              width: 3, // Sesuaikan lebar kolom
              styles: const PosStyles(align: PosAlign.right),
            ),
            PosColumn(
              text: currency.format(itemTotal).padLeft(7), // Total per item
              width: 2, // Sesuaikan lebar kolom
              styles: const PosStyles(align: PosAlign.right),
            ),
          ]);
        }
      } else {
        log('Data "items" tidak ditemukan atau bukan List.');
      }

      bytes += generator.hr();

      // Pastikan semua nilai numerik yang diambil dari 'data' dikonversi ke double
      // Gunakan (data['key'] as num?)?.toDouble() ?? 0.0 untuk keamanan
      double subtotal = (data['subtotal'] as num?)?.toDouble() ?? 0.0;
      double discountPercentage = (data['discount_percentage'] as num?)?.toDouble() ?? 0.0;
      double ppnPercentage = (data['ppn_percentage'] as num?)?.toDouble() ?? 0.0;
      double totalAmount = (data['total_amount'] as num?)?.toDouble() ?? 0.0;

      double discountAmount = subtotal * discountPercentage;
      double amountAfterDiscount = subtotal - discountAmount;
      double ppnAmount = amountAfterDiscount * ppnPercentage;

      bytes += generator.row([
        PosColumn(text: "Subtotal", width: 6),
        PosColumn(
          text: "Rp${currency.format(subtotal)}",
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
      bytes += generator.row([
        PosColumn(text: "Diskon (${(discountPercentage * 100).toInt()}%)", width: 6),
        PosColumn(
          text: "-Rp${currency.format(discountAmount)}",
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
      bytes += generator.row([
        PosColumn(text: "PPN (${(ppnPercentage * 100).toInt()}%)", width: 6),
        PosColumn(
          text: "+Rp${currency.format(ppnAmount)}",
          width: 6,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
      bytes += generator.hr();
      bytes += generator.row([
        PosColumn(
          text: "TOTAL",
          width: 6,
          styles: const PosStyles(bold: true, height: PosTextSize.size2, width: PosTextSize.size2),
        ),
        PosColumn(
          text: "Rp${currency.format(totalAmount)}",
          width: 6,
          styles: const PosStyles(
            align: PosAlign.right,
            bold: true,
            height: PosTextSize.size2,
            width: PosTextSize.size2,
          ),
        ),
      ]);
      bytes += generator.feed(2);
      bytes += generator.text("Terima kasih telah berbelanja di BY CAFE!",
          styles: const PosStyles(align: PosAlign.center));
      bytes += generator.feed(3);
      bytes += generator.cut();

      final result = await PrintBluetoothThermal.writeBytes(bytes);
      if (result) {
        Get.snackbar("Sukses", "Struk berhasil dicetak.");
      } else {
        Get.snackbar("Error", "Gagal mencetak ke printer. Periksa koneksi.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
            colorText: Get.theme.colorScheme.onError);
      }
    } catch (e) {
      log("❌ Gagal mencetak struk: $e");
      Get.snackbar("Error", "Gagal mencetak struk: ${e.toString()}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Get.theme.colorScheme.error.withOpacity(0.8),
          colorText: Get.theme.colorScheme.onError);
    }
  }
}