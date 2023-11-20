import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/modules/book/domain/entities/book_entity.dart';

abstract class ILocalStorageRepository {
  Future<Either<Failure, List<BookEntity>>> getFavoriteBooks();
  Future<Either<Failure, List<BookEntity>>> addToFavoriteBooks(
      {required BookEntity book});
  Future<Either<Failure, List<BookEntity>>> removeFromFavoriteBooks(
      {required BookEntity book});
}
