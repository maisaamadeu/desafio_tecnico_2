import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/modules/book/domain/entities/book_entity.dart';

abstract class IBooksRepository {
  Future<Either<Failure, List<BookEntity>>> fetchAllBooks();
}
