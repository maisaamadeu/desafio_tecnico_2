import 'package:desafio_tecnico_2/features/infra/models/book_model.dart';

abstract class IBooksDatasource {
  Future<List<BookModel>> fetchAllBooks();
}
