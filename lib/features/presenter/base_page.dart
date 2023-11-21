import 'package:desafio_tecnico_2/features/presenter/books_page.dart';
import 'package:desafio_tecnico_2/features/presenter/favorite_books_page.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/all_books_store.dart';
import 'package:desafio_tecnico_2/features/presenter/widgets/custom_elevated_button.dart';
import 'package:desafio_tecnico_2/features/presenter/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BasePage extends StatelessWidget {
  BasePage({super.key});

  final PageController pageController = PageController(initialPage: 0);

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
                    onPressed: () {},
                    text: 'Livros',
                    buttonColor: Colors.green,
                    iconData: Icons.book,
                    iconColor: Colors.white,
                    textStyle: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomElevatedButton(
                    onPressed: () {},
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
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: [
                    BooksPage(),
                    FavoriteBooksPage(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
