import 'package:desafio_tecnico_2/modules/book/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/modules/book/infra/models/book_model.dart';

abstract class ILocalStorageDatasource {
  Future<List<BookEntity>> getFavoriteBooks();
  Future<List<BookEntity>> addToFavoriteBooks({required BookEntity book});
  Future<List<BookEntity>> removeFromFavoriteBooks({required BookEntity book});
}
