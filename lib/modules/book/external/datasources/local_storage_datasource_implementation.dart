import 'dart:convert';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/modules/book/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/modules/book/infra/datasources/local_storage_datasource.dart';
import 'package:desafio_tecnico_2/modules/book/infra/models/book_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageDatasourceImplementation implements ILocalStorageDatasource {
  final SharedPreferences sharedPreferences;

  LocalStorageDatasourceImplementation({required this.sharedPreferences});

  @override
  Future<List<BookEntity>> getFavoriteBooks() async {
    try {
      // final List<String> encodedFavorites =
      //     sharedPreferences.getStringList('favoriteBooks') ?? [];
      // print(encodedFavorites);

      return [];
    } catch (e) {
      throw LocalStorageFailure(message: 'Failed to get favorite books');
    }
  }

  @override
  Future<List<BookEntity>> addToFavoriteBooks(
      {required BookEntity book}) async {
    try {
      final List<BookEntity> currentFavorites = await getFavoriteBooks();

      currentFavorites.add(book);

      await saveFavoriteBooks(currentFavorites);

      return currentFavorites;
    } catch (e) {
      throw LocalStorageFailure(message: 'Failed to add book to favorites');
    }
  }

  @override
  Future<List<BookEntity>> removeFromFavoriteBooks(
      {required BookEntity book}) async {
    try {
      final List<BookEntity> currentFavorites = await getFavoriteBooks();

      currentFavorites.removeWhere((favorite) => favorite.id == book.id);

      await saveFavoriteBooks(currentFavorites);

      return currentFavorites;
    } catch (e) {
      throw LocalStorageFailure(
          message: 'Failed to remove book from favorites');
    }
  }

  Future<void> verifyContainsKey() async {
    if (sharedPreferences.containsKey('favoriteBooks')) {
      return;
    } else {
      sharedPreferences.setStringList('favoriteBooks', []);
    }
  }

  Future<void> saveFavoriteBooks(List<BookEntity> favorites) async {
    final encodedFavorites = jsonEncode(
      favorites.map((book) => BookModel.fromBookEntity(book).toJson()).toList(),
    );
    await sharedPreferences.setString('favoriteBooks', encodedFavorites);
  }
}
