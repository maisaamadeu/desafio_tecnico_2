import 'dart:convert';
import 'package:desafio_tecnico_2/core/usecase/errors/failures.dart';
import 'package:desafio_tecnico_2/modules/book/infra/datasources/local_storage_datasource.dart';
import 'package:desafio_tecnico_2/modules/book/infra/models/book_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageDatasourceImplementation implements ILocalStorageDatasource {
  final SharedPreferences sharedPreferences;

  LocalStorageDatasourceImplementation({required this.sharedPreferences});

  @override
  Future<List<BookModel>> getFavoriteBooks() async {
    try {
      verifyContainsKey();

      final List<String> encodedFavorites =
          sharedPreferences.getStringList('favoriteBooks') ?? [];

      final List<BookModel> decodedFavorites = encodedFavorites
          .map((e) => BookModel.fromJson(json.decode(e)))
          .toList();

      return decodedFavorites;
    } catch (e) {
      throw LocalStorageFailure(message: 'Failed to get favorite books');
    }
  }

  @override
  Future<List<BookModel>> addToFavoriteBooks({required BookModel book}) async {
    try {
      final List<BookModel> currentFavorites = await getFavoriteBooks();

      currentFavorites.add(book);

      await saveFavoriteBooks(currentFavorites);

      return currentFavorites;
    } catch (e) {
      throw LocalStorageFailure(message: 'Failed to add book to favorites');
    }
  }

  @override
  Future<List<BookModel>> removeFromFavoriteBooks(
      {required BookModel book}) async {
    try {
      final List<BookModel> currentFavorites = await getFavoriteBooks();

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

  Future<void> saveFavoriteBooks(List<BookModel> favorites) async {
    final encodedFavorites =
        favorites.map((e) => json.encode(e.toJson())).toList();
    await sharedPreferences.setStringList('favoriteBooks', encodedFavorites);
  }
}
