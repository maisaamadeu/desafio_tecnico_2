import 'package:dartz/dartz.dart';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2/modules/book/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/modules/book/domain/repositories/books_repository.dart';
import 'package:desafio_tecnico_2/modules/book/domain/usecases/fetch_all_books_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBooksRepository extends Mock implements IBooksRepository {}

void main() {
  late IBooksRepository repository;
  late FetchAllBooksUsecase usecase;

  setUp(() {
    repository = MockBooksRepository();
    usecase = FetchAllBooksUsecase(repository: repository);
  });

  final tListBookEntity = [
    BookEntity(
        id: 5,
        title: "Lupe",
        author: "Affonso Celso",
        coverUrl:
            "https://www.gutenberg.org/cache/epub/63606/pg63606.cover.medium.jpg",
        downloadUrl: "https://www.gutenberg.org/ebooks/63606.epub3.images"),
  ];

  final NoParams noParams = NoParams();

  test('should get a list of book entity from the repository', () async {
    // Arrange
    when(() => repository.fetchAllBooks())
        .thenAnswer((invocation) async => Right(tListBookEntity));

    // Act
    final result = await usecase(noParams);

    // Assert
    expect(result, Right(tListBookEntity));
  });

  test("should return a ServerFailure when don't succeed", () async {
    // Arrange
    when(() => repository.fetchAllBooks())
        .thenAnswer((invocation) async => Left(ServerFailure()));

    // Act
    final result = await usecase(noParams);

    // Assert
    expect(result, Left(ServerFailure()));
  });
}
