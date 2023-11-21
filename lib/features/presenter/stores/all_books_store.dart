import 'package:desafio_tecnico_2/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/domain/usecases/fetch_all_books_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class AllBooksStore extends GetxController {
  final FetchAllBooksUsecase fetchAllBooksUsecase =
      Modular.get<FetchAllBooksUsecase>();

  RxBool isLoading = RxBool(false);
  RxList<BookEntity> books = <BookEntity>[].obs;

  Future<void> fetchAllBooks() async {
    isLoading(true);

    final response = await fetchAllBooksUsecase(NoParams());

    response.fold((l) => null, (r) {
      books.value = r;
    });

    isLoading(false);
  }

  Future<void> updateListBooks(List<BookEntity> newBooks) async {
    isLoading(true);

    books.value = newBooks;

    isLoading(false);
  }

  @override
  void onInit() async {
    super.onInit();
    await fetchAllBooks();
  }
}
