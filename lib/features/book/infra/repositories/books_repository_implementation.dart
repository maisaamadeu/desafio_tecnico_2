import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/exceptions.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/features/book/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/book/domain/repositories/books_repository.dart';
import 'package:desafio_tecnico_2/features/book/infra/datasources/books_datasource.dart';

class BooksRepositoryImplementation implements IBooksRepository {
  final IBooksDatasource datasource;

  BooksRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, List<BookEntity>>> fetchAllBooks() async {
    try {
      final result = await datasource.fetchAllBooks();
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
