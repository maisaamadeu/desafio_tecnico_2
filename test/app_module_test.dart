import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/app_module.dart';
import 'package:desafio_tecnico_2/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2/modules/book/domain/usecases/fetch_all_books_usecase.dart';
import 'package:desafio_tecnico_2/modules/book/infra/models/book_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    Modular.init(AppModule());
  });

  test('should return the use case without errors', () {
    final usecase = Modular.get<FetchAllBooksUsecase>();
    expect(usecase, isA<FetchAllBooksUsecase>());
  });

  final NoParams noParams = NoParams();

  test('should return a list of books', () async {
    final usecase = Modular.get<FetchAllBooksUsecase>();
    final result = await usecase(noParams);
    expect(result.fold(id, id), isA<List<BookModel>>());
  });
}
