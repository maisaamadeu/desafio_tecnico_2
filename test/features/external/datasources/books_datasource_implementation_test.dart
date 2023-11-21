import 'dart:convert';

import 'package:desafio_tecnico_2/core/usecase/errors/exceptions.dart';
import 'package:desafio_tecnico_2/features/external/datasources/books_datasource_implementation.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import '../../mocks/list_books_mock.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late Dio dio;
  late BooksDatasourceImplementation datasource;

  setUp(() {
    dio = MockDio();
    datasource = BooksDatasourceImplementation(dio: dio);
  });

  test('should return a list of book model', () async {
    // Arrange
    when(() => dio.get("https://escribo.com/books.json")).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(),
        statusCode: 200,
        data: jsonDecode(listBooksMock),
      ),
    );

    // Act
    final future = datasource.fetchAllBooks();

    // Assert
    expect(future, completes);
  });

  test('should return an Exception if the status code is not equal 200',
      () async {
    // Arrange
    when(() => dio.get("https://escribo.com/books.json")).thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(),
        statusCode: 401,
        data: null,
      ),
    );

    // Act
    final future = datasource.fetchAllBooks();

    // Assert
    expect(future, throwsA(isA<ServerException>()));
  });

  test('should return an Exception if Dio has an error', () async {
    // Arrange
    when(() => dio.get("https://escribo.com/books.json"))
        .thenThrow(Exception());

    // Act
    final future = datasource.fetchAllBooks();

    // Assert
    expect(future, throwsA(isA<Exception>()));
  });
}
