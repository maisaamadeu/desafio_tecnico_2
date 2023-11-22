import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasePageStore extends GetxController {
  RxInt page = 0.obs;
  Rx<PageController> pageController = PageController(initialPage: 0).obs;

  void navigateToPage() async {
    pageController.value.animateToPage(
      page.value,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
