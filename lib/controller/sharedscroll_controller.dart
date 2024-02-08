import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedScrollController extends GetxController {
  ScrollController scrollController = ScrollController();
  moveToTop() {
    scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.easeIn);
  }
}
