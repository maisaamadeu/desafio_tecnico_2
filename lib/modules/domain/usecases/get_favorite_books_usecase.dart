import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2/modules/book/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/modules/book/domain/repositories/local_storage_repository.dart';

class GetFavoriteBooksUsecase implements Usecase<List<BookEntity>, NoParams> {
  final ILocalStorageRepository repository;

  GetFavoriteBooksUsecase({required this.repository});

  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams params) async {
    return await repository.getFavoriteBooks();
  }
}
