import 'package:desafio_tecnico_2/modules/book/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/modules/book/infra/models/book_model.dart';

abstract class ILocalStorageDatasource {
  Future<List<BookModel>> getFavoriteBooks();
  Future<List<BookModel>> addToFavoriteBooks({required BookEntity book});
  Future<List<BookModel>> removeFromFavoriteBooks({required BookEntity book});
}
