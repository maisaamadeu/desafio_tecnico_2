import 'dart:convert';

import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/modules/book/external/datasources/local_storage_datasource_implementation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:desafio_tecnico_2/modules/book/infra/models/book_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('LocalStorageDatasourceImplementation', () {
    late SharedPreferences sharedPreferences;
    late LocalStorageDatasourceImplementation datasource;

    setUp(() async {
      WidgetsFlutterBinding.ensureInitialized();
      sharedPreferences = MockSharedPreferences();
      datasource = LocalStorageDatasourceImplementation(
        sharedPreferences: sharedPreferences,
      );
    });

    group('getFavoriteBooks', () {
      test('should return an empty list if no favorites are stored', () async {
        when(() => sharedPreferences.getStringList('favoriteBooks'))
            .thenReturn([]);

        final result = await datasource.getFavoriteBooks();

        expect(result, []);
      });

      test('should return a list of favorite books if stored', () async {
        const mockJsonData =
            '[{"id": "1", "title": "Book 1", "author": "Author 1", "cover_url": "url", "download_url": "url"}]';
        when(() => sharedPreferences.getString('favoriteBooks'))
            .thenReturn(mockJsonData);

        final result = await datasource.getFavoriteBooks();

        expect(result, isNotEmpty);
        expect(result.first.id, 1);
        expect(result.first.title, 'Book 1');
        expect(result.first.author, 'Author 1');
        expect(result.first.coverUrl, 'url');
        expect(result.first.downloadUrl, 'url');
      });

      test('should throw LocalStorageFailure if decoding fails', () {
        when(() => sharedPreferences.getString('favoriteBooks'))
            .thenReturn('invalid_json');

        expect(() => datasource.getFavoriteBooks(),
            throwsA(isA<LocalStorageFailure>()));
      });
    });

    group('addToFavoriteBooks', () {
      test('should add a book to favorites and return the updated list', () {
        final initialFavorites = <BookModel>[];
        when(() => sharedPreferences.getString('favoriteBooks'))
            .thenReturn(jsonEncode(initialFavorites));
        when(() => sharedPreferences.setString('favoriteBooks', "any"))
            .thenAnswer((_) => Future.value(true));

        final newFavorite = BookModel(
            id: 1,
            title: 'Book 1',
            author: 'Author 1',
            coverUrl: 'url',
            downloadUrl: 'url');
        final result = datasource.addToFavoriteBooks(book: newFavorite);

        expect(result, contains(newFavorite));
      });

      test('should throw LocalStorageFailure if adding fails', () {
        when(() => sharedPreferences.getString('favoriteBooks'))
            .thenReturn(jsonEncode([]));
        when(() => sharedPreferences.setString('favoriteBooks', "any"))
            .thenAnswer((_) => Future.value(false));

        final newFavorite = BookModel(
            id: 1,
            title: 'Book 1',
            author: 'Author 1',
            coverUrl: 'url',
            downloadUrl: 'url');

        expect(() => datasource.addToFavoriteBooks(book: newFavorite),
            throwsA(isA<LocalStorageFailure>()));
      });
    });

    group('removeFromFavoriteBooks', () {
      test('should remove a book from favorites and return the updated list',
          () {
        final initialFavorites = <BookModel>[
          BookModel(
              id: 1,
              title: 'Book 1',
              author: 'Author 1',
              coverUrl: 'url',
              downloadUrl: 'url'),
          BookModel(
              id: 2,
              title: 'Book 2',
              author: 'Author 2',
              coverUrl: 'url',
              downloadUrl: 'url'),
        ];
        when(() => sharedPreferences.getString('favoriteBooks'))
            .thenReturn(jsonEncode(initialFavorites));
        when(() => sharedPreferences.setString('favoriteBooks', "any"))
            .thenAnswer((_) => Future.value(true));

        final bookToRemove = initialFavorites.first;
        final result = datasource.removeFromFavoriteBooks(book: bookToRemove);

        expect(result, isNot(contains(bookToRemove)));
      });

      test('should throw LocalStorageFailure if removing fails', () {
        final initialFavorites = <BookModel>[
          BookModel(
              id: 1,
              title: 'Book 1',
              author: 'Author 1',
              coverUrl: 'url',
              downloadUrl: 'url'),
        ];
        when(() => sharedPreferences.getString('favoriteBooks'))
            .thenReturn(jsonEncode(initialFavorites));
        when(() => sharedPreferences.setString('favoriteBooks', "any"))
            .thenAnswer((_) => Future.value(false));

        final bookToRemove = initialFavorites.first;

        expect(() => datasource.removeFromFavoriteBooks(book: bookToRemove),
            throwsA(isA<LocalStorageFailure>()));
      });
    });
  });
}
