import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/domain/repositories/local_storage_repository.dart';

import 'package:desafio_tecnico_2/features/infra/models/book_model.dart';

class RemoveFromFavoriteBooksUsecase
    implements Usecase<List<BookEntity>, BookEntity> {
  final ILocalStorageRepository repository;

  RemoveFromFavoriteBooksUsecase({required this.repository});

  @override
  Future<Either<Failure, List<BookEntity>>> call(BookEntity book) async {
    return await repository.removeFromFavoriteBooks(
        book: BookModel.fromBookEntity(book));
  }
}
