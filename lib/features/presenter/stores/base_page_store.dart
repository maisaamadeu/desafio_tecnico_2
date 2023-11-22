import 'package:desafio_tecnico_2/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/domain/usecases/fetch_all_books_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class BasePageStore extends GetxController {
  int page = 0;
  Rx<PageController> pageController = PageController(initialPage: 0).obs;

  void navigateToPage() async {
    pageController.value.animateToPage(
      page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }
}
