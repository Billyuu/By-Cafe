import 'package:get/get.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';
import 'package:bycafe/app/modules/service/printer_service.dart';

class PrinterController extends GetxController {
  final PrinterService printerService = Get.find();

  final RxString statusMessage = ''.obs;

  RxBool get isConnected => printerService.isConnected;
  RxBool get isScanning => printerService.isScanning;
  RxList<BluetoothInfo> get devices => printerService.availableDevices; //daftar printer
  RxString get selectedPrinter => printerService.macAddress; //alamat

  @override
  void onInit() {
    super.onInit();
    scanBluetooth();
  }

  void scanBluetooth() async {
    statusMessage.value = "🔍 Scanning...";
    await printerService.scanDevices();
    statusMessage.value = "✅ ${devices.length} perangkat ditemukan";
  }

  void connect(String mac) async {
    statusMessage.value = "🔌 Menghubungkan ke $mac...";
    await printerService.connect(mac);
    statusMessage.value = isConnected.value
        ? "✅ Terhubung ke printer"
        : "❌ Gagal terhubung";
  }

  void disconnect() async {
    await printerService.disconnect();
    statusMessage.value = "🔌 Koneksi diputus";
  }

  void printTest() async {
    statusMessage.value = "🧪 Tes print...";
    await printerService.printTest();
  }

  Future<void> printReceipt(Map<String, dynamic> data) async {
    statusMessage.value = "🖨️ Mencetak struk...";
    await printerService.printReceipt(data);
  }
}
