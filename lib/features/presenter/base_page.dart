import 'package:desafio_tecnico_2/features/presenter/books_page.dart';
import 'package:desafio_tecnico_2/features/presenter/favorite_books_page.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/all_books_store.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/base_page_store.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/favorite_books_store.dart';
import 'package:desafio_tecnico_2/features/presenter/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BasePage extends StatelessWidget {
  BasePage({super.key});

  final BasePageStore basePageStore = Get.put(BasePageStore());
  final FavoriteBooksStore favoriteBooksStore =
      Get.put<FavoriteBooksStore>(FavoriteBooksStore());
  final AllBooksStore allBooksStore = Get.put<AllBooksStore>(AllBooksStore());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  CustomElevatedButton(
                    onPressed: () {
                      basePageStore.page = 0;
                      basePageStore.navigateToPage();
                    },
                    text: 'Livros',
                    buttonColor: basePageStore.page == 0
                        ? Colors.green
                        : Colors.green.shade100,
                    iconData: Icons.book,
                    iconColor: Colors.white,
                    textStyle: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomElevatedButton(
                    onPressed: () {
                      basePageStore.page = 1;
                      basePageStore.navigateToPage();
                    },
                    text: 'Favoritos',
                    buttonColor: Colors.red,
                    iconData: Icons.favorite,
                    iconColor: Colors.white,
                    textStyle: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Obx(() {
                return Expanded(
                  child: PageView(
                    controller: basePageStore.pageController.value,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      BooksPage(),
                      FavoriteBooksPage(),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
