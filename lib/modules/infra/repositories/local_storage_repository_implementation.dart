import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/exceptions.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/modules/book/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/modules/book/domain/repositories/local_storage_repository.dart';
import 'package:desafio_tecnico_2/modules/book/infra/datasources/local_storage_datasource.dart';
import 'package:desafio_tecnico_2/modules/book/infra/models/book_model.dart';

class LocalStorageRepositoryImplementation implements ILocalStorageRepository {
  final ILocalStorageDatasource datasource;

  LocalStorageRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, List<BookEntity>>> getFavoriteBooks() async {
    try {
      final result = await datasource.getFavoriteBooks();
      return Right(result);
    } on LocalStorageException {
      return Left(LocalStorageFailure(message: 'Failed to get favorite books'));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> addToFavoriteBooks(
      {required BookModel book}) async {
    try {
      final result = await datasource.addToFavoriteBooks(book: book);
      return Right(result);
    } on LocalStorageException {
      return Left(
          LocalStorageFailure(message: 'Failed to add book to favorites'));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> removeFromFavoriteBooks(
      {required BookModel book}) async {
    try {
      final result = await datasource.removeFromFavoriteBooks(book: book);
      return Right(result);
    } on LocalStorageException {
      return Left(
          LocalStorageFailure(message: 'Failed to remove book from favorites'));
    }
  }
}
