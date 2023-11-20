import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/exceptions.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/features/book/infra/datasources/books_datasource.dart';
import 'package:desafio_tecnico_2/features/book/infra/models/book_model.dart';
import 'package:desafio_tecnico_2/features/book/infra/repositories/books_repository_implementation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBooksDatasource extends Mock implements IBooksDatasource {}

void main() {
  late IBooksDatasource datasource;
  late BooksRepositoryImplementation repository;

  setUp(() {
    datasource = MockBooksDatasource();
    repository = BooksRepositoryImplementation(datasource: datasource);
  });

  final tListBookModel = [
    BookModel(
      id: 4,
      title: "Lupe",
      author: "Affonso Celso",
      coverUrl:
          "https://www.gutenberg.org/cache/epub/63606/pg63606.cover.medium.jpg",
      downloadUrl: "https://www.gutenberg.org/ebooks/63606.epub3.images",
    )
  ];

  test(
    'should return list of book model when calls the datasource',
    () async {
      // Arrange
      when(datasource.fetchAllBooks).thenAnswer(
        (invocation) async => tListBookModel,
      );

      // Act
      final result = await repository.fetchAllBooks();

      // Assert
      expect(
        result,
        Right(tListBookModel),
      );
    },
  );

  test(
    'should return a server failure when the calls to datasource is unsuccessful',
    () async {
      // Arrange
      when(datasource.fetchAllBooks).thenThrow(ServerException());

      // Act
      final result = await repository.fetchAllBooks();

      // Assert
      expect(
        result,
        Left(ServerFailure()),
      );
    },
  );
}
