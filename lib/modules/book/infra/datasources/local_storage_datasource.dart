import 'package:desafio_tecnico_2/modules/book/infra/models/book_model.dart';

abstract class ILocalStorageDatasource {
  Future<List<BookModel>> getFavoriteBooks();
  Future<List<BookModel>> addToFavoriteBooks({required BookModel book});
  Future<List<BookModel>> removeFromFavoriteBooks({required BookModel book});
}
