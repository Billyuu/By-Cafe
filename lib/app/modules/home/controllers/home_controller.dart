import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

final isKeyboardVisible = false.obs;
final textFocus = FocusNode();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    textFocus.addListener(() {
      isKeyboardVisible.value = textFocus.hasFocus;
    });
  }
@override
  void onClose() {
    textFocus.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    super.onReady();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

//   void increment() => count.value++;
// }
}