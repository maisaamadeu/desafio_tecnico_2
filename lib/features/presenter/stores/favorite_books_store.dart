import 'package:desafio_tecnico_2/core/usecase/usecase.dart';
import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/domain/usecases/add_to_favorite_books_usecase.dart';
import 'package:desafio_tecnico_2/features/domain/usecases/get_favorite_books_usecase.dart';
import 'package:desafio_tecnico_2/features/domain/usecases/remove_from_favorite_books_usecase.dart';
import 'package:desafio_tecnico_2/features/external/datasources/local_storage_datasource_implementation.dart';
import 'package:desafio_tecnico_2/features/infra/repositories/local_storage_repository_implementation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBooksStore extends GetxController {
  late SharedPreferences preferences;
  late LocalStorageDatasourceImplementation datasource;
  late LocalStorageRepositoryImplementation repository;
  late GetFavoriteBooksUsecase getFavoriteBooksUsecase;
  late AddToFavoriteBooksUsecase addToFavoriteBooksUsecase;
  late RemoveFromFavoriteBooksUsecase removeFromFavoriteBooksUsecase;

  @override
  void onInit() async {
    super.onInit();
    preferences = await SharedPreferences.getInstance();
    datasource =
        LocalStorageDatasourceImplementation(sharedPreferences: preferences);
    repository = LocalStorageRepositoryImplementation(datasource: datasource);
    getFavoriteBooksUsecase = GetFavoriteBooksUsecase(repository: repository);
    addToFavoriteBooksUsecase =
        AddToFavoriteBooksUsecase(repository: repository);
    removeFromFavoriteBooksUsecase =
        RemoveFromFavoriteBooksUsecase(repository: repository);
  }

  RxBool isLoading = RxBool(false);
  RxList<BookEntity> favoriteBooks = <BookEntity>[].obs;

  Future<void> getFavoriteBooks() async {
    isLoading(true);
    final result = await getFavoriteBooksUsecase(NoParams());
    result.fold((l) => null, (r) {
      favoriteBooks.value = r;
      isLoading(false);
    });
  }

  Future<void> addToFavoriteBooks(BookEntity book) async {
    isLoading(true);
    final result = await addToFavoriteBooksUsecase(book);
    result.fold((l) => null, (r) {
      favoriteBooks.value = r;
      isLoading(false);
    });
  }

  Future<void> removeFromFavoriteBooks(BookEntity book) async {
    isLoading(true);
    final result = await removeFromFavoriteBooksUsecase(book);
    result.fold((l) => null, (r) {
      favoriteBooks.value = r;
      isLoading(false);
    });
  }

  verifyIfBookIsFavorite(BookEntity book) {
    return favoriteBooks.contains(book);
  }
}
