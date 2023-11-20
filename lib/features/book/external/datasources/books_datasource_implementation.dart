import 'package:desafio_tecnico_2/core/usecase/errors/exceptions.dart';
import 'package:desafio_tecnico_2/features/book/infra/datasources/books_datasource.dart';
import 'package:desafio_tecnico_2/features/book/infra/models/book_model.dart';
import 'package:dio/dio.dart';

class BooksDatasourceImplementation implements IBooksDatasource {
  final Dio dio;

  BooksDatasourceImplementation({required this.dio});

  @override
  Future<List<BookModel>> fetchAllBooks() async {
    final response = await dio.get("https://escribo.com/books.json");

    if (response.statusCode == 200) {
      final List<BookModel> booksModels =
          (response.data as List).map((e) => BookModel.fromJson(e)).toList();

      return booksModels;
    } else {
      throw ServerException();
    }
  }
}
