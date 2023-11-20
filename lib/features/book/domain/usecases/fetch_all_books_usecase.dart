import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2/features/book/domain/entities/book_entity.dart';

class FetchAllBooksUseCase implements UseCase<List<BookEntity>, NoParams> {
  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
