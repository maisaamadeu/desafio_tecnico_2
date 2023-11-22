import 'package:desafio_tecnico_2/features/domain/usecases/fetch_all_books_usecase.dart';
import 'package:desafio_tecnico_2/features/domain/usecases/remove_from_favorite_books_usecase.dart';
import 'package:desafio_tecnico_2/features/external/datasources/books_datasource_implementation.dart';
import 'package:desafio_tecnico_2/features/infra/repositories/books_repository_implementation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => Dio()),
        Bind((i) => RemoveFromFavoriteBooksUsecase(repository: i())),
        Bind((i) => BooksDatasourceImplementation(dio: i())),
        Bind((i) => BooksRepositoryImplementation(datasource: i())),
        Bind((i) => FetchAllBooksUsecase(repository: i())),
      ];
}
