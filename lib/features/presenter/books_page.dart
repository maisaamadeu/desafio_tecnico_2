import 'package:desafio_tecnico_2/features/presenter/stores/all_books_store.dart';
import 'package:desafio_tecnico_2/features/presenter/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class BooksPage extends StatelessWidget {
  BooksPage({super.key});

  final AllBooksStore allBooksStore = Get.put<AllBooksStore>(AllBooksStore());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Obx(
              () => Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    mainAxisExtent: 410,
                    maxCrossAxisExtent: 200,
                  ),
                  itemBuilder: (context, index) => BookCard(
                    book: allBooksStore.books[index],
                  ),
                  itemCount: allBooksStore.books.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
