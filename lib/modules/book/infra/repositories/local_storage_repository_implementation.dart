import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/exceptions.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/modules/book/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/modules/book/domain/repositories/local_storage_repository.dart';
import 'package:desafio_tecnico_2/modules/book/infra/datasources/local_storage_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepositoryImplementation implements ILocalStorageRepository {
  final ILocalStorageDatasource datasource;

  LocalStorageRepositoryImplementation({required this.datasource});

  @override
  Future<Either<Failure, List<BookEntity>>> addToFavoriteBooks(
      {required BookEntity book}) async {
    try {
      final result = await datasource.addToFavoriteBooks(book: book);
      return Right(result);
    } on SharedPreferencesException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getFavoriteBooks() async {
    try {
      final result = await datasource.getFavoriteBooks();
      return Right(result);
    } on SharedPreferencesException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> removeFromFavoriteBooks(
      {required BookEntity book}) async {
    try {
      final result = await datasource.removeFromFavoriteBooks(book: book);
      return Right(result);
    } on SharedPreferencesException {
      return Left(ServerFailure());
    }
  }
}
