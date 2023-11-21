import 'package:desafio_tecnico_2/features/presenter/stores/all_books_store.dart';
import 'package:desafio_tecnico_2/features/presenter/widgets/custom_elevated_button_widget.dart';
import 'package:desafio_tecnico_2/features/presenter/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AllBooksStore allBooksStore = Get.put<AllBooksStore>(AllBooksStore());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  CustomElevatedButtonWidget(
                    onPressed: () {},
                    text: 'Livros',
                    buttonColor: Colors.green,
                    iconData: Icons.book,
                    iconColor: Colors.white,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomElevatedButtonWidget(
                    onPressed: () {},
                    text: 'Favoritos',
                    buttonColor: Colors.red,
                    iconData: Icons.favorite,
                    iconColor: Colors.white,
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Obx(
                () => SizedBox(
                  height: 500,
                  child: ListView.separated(
                    itemBuilder: (context, index) =>
                        BookCard(book: allBooksStore.books[index]),
                    itemCount: allBooksStore.books.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 10),
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
