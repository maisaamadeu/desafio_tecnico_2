import 'package:desafio_tecnico_2/features/presenter/stores/all_books_store.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/book_store.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/favorite_books_store.dart';
import 'package:desafio_tecnico_2/features/presenter/theme/app_colors.dart';
import 'package:desafio_tecnico_2/features/presenter/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BooksPage extends StatelessWidget {
  BooksPage({super.key});

  final AllBooksStore allBooksStore = Get.find<AllBooksStore>();
  final FavoriteBooksStore favoriteBooksStore = Get.find<FavoriteBooksStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Obx(
              () {
                if (allBooksStore.isLoading.value) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors().primaryColor,
                      ),
                    ),
                  );
                }

                if (allBooksStore.hasError.value ||
                    favoriteBooksStore.hasError.value) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                          'Ocorreu um erro durante a execução do aplicativo. Reinicie e tente novamente'),
                    ),
                  );
                }

                return Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      mainAxisExtent: 410,
                      maxCrossAxisExtent: 200,
                    ),
                    itemBuilder: (context, index) => BookCard(
                      bookStore: Get.put(
                          BookStore(
                            book: allBooksStore.books[index],
                          ),
                          tag: allBooksStore.books[index].id.toString()),
                      book: allBooksStore.books[index],
                    ),
                    itemCount: allBooksStore.books.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
