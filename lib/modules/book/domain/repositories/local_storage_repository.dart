import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/modules/book/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/modules/book/infra/models/book_model.dart';

abstract class ILocalStorageRepository {
  Future<Either<Failure, List<BookEntity>>> getFavoriteBooks();
  Future<Either<Failure, List<BookEntity>>> addToFavoriteBooks(
      {required BookModel book});
  Future<Either<Failure, List<BookEntity>>> removeFromFavoriteBooks(
      {required BookModel book});
}
