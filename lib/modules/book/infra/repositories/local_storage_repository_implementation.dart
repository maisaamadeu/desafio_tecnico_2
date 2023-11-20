import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/modules/book/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/modules/book/domain/repositories/local_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepositoryImplementation implements ILocalStorageRepository {
  @override
  Future<Either<Failure, List<BookEntity>>> addToFavoriteBooks(
      {required BookEntity book}) {
    // TODO: implement addToFavoriteBooks
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getFavoriteBooks() {
    // TODO: implement getFavoriteBooks
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BookEntity>>> removeFromFavoriteBooks(
      {required BookEntity book}) {
    // TODO: implement removeFromFavoriteBooks
    throw UnimplementedError();
  }
}
