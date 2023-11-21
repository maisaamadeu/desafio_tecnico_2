import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/domain/repositories/books_repository.dart';

class FetchAllBooksUsecase implements Usecase<List<BookEntity>, NoParams> {
  final IBooksRepository repository;

  FetchAllBooksUsecase({required this.repository});

  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams params) async {
    return await repository.fetchAllBooks();
  }
}
