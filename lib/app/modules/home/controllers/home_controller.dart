import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final isKeyboardVisible = false.obs;
  final textFocus = FocusNode();

  var currentIndex = 0.obs;

  var imageList = [
    {
      'image': 'assets/background.jpg',
      'text': "We'll be back",
      'text2': 'we promised.',
      'logo': 'assets/mocacino.png' 
    },
    {
      'image': 'assets/background3.jpg',
      'text': 'Our Coffee',
      'text2': 'Our Fun.',
      'logo': 'assets/goodday.png' 
    },
    {
      'image': 'assets/background4.jpg',
      'text': 'Story About ',
      'text2': 'Cup Of Coffee!',
      'logo':  'assets/copi.png'
    },
  ];

  void onPageChanged(int index) {
    currentIndex.value = index;
  }
}
