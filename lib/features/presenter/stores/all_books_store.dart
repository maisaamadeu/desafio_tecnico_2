import 'package:desafio_tecnico_2/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/domain/usecases/fetch_all_books_usecase.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

class AllBooksStore extends GetxController {
  final FetchAllBooksUsecase fetchAllBooksUsecase =
      Modular.get<FetchAllBooksUsecase>();

  RxList<BookEntity> books = <BookEntity>[].obs;

  Future<void> fetchAllBooks() async {
    final response = fetchAllBooksUsecase(NoParams());
    print(response);
  }
}
