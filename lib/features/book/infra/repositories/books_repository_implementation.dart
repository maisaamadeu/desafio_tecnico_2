import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/features/book/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/book/domain/repositories/books_repository.dart';
import 'package:desafio_tecnico_2/features/book/infra/datasources/books_datasource.dart';

class BooksRepositoryImplementation implements IBooksRepository {
  final BooksDatasource datasource;

  BooksRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, List<BookEntity>>> fetchAllBooks() {
    // TODO: implement fetchAllBooks
    throw UnimplementedError();
  }
}
