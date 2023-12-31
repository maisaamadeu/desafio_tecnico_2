import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/book_store.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/favorite_books_store.dart';
import 'package:desafio_tecnico_2/features/presenter/theme/app_colors.dart';
import 'package:desafio_tecnico_2/features/presenter/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteBooksPage extends StatelessWidget {
  FavoriteBooksPage({super.key});

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
                if (favoriteBooksStore.isLoading.value) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors().primaryColor,
                      ),
                    ),
                  );
                }

                if (favoriteBooksStore.hasError.value) {
                  return const Expanded(
                    child: Center(
                      child: Text(
                          'Ocorreu um erro durante a execução do aplicativo. Reinicie e tente novamente'),
                    ),
                  );
                }

                List<BookEntity> reversedBooks =
                    favoriteBooksStore.favoriteBooks.reversed.toList();

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
                        BookStore(book: reversedBooks[index]),
                        tag: reversedBooks[index].id.toString(),
                      ),
                      book: reversedBooks[index],
                    ),
                    itemCount: reversedBooks.length,
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
