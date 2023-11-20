import 'package:desafio_tecnico_2/features/book/infra/models/book_model.dart';

abstract class BooksDatasource {
  Future<List<BookModel>> fetchAllBooks();
}
