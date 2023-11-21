import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/favorite_books_store.dart';
import 'package:get/get.dart';

class BookStore extends GetxController {
  final FavoriteBooksStore favoriteBooksStore = Get.find<FavoriteBooksStore>();
  RxBool isFavorited = RxBool(false);

  final BookEntity book;

  BookStore({required this.book});

  Future<void> addToFavoriteBooks(BookEntity book) async {
    favoriteBooksStore.addToFavoriteBooks(book);
    isFavorited(true);
  }

  Future<void> removeFromFavoriteBooks(BookEntity book) async {
    favoriteBooksStore.removeFromFavoriteBooks(book);
    isFavorited(false);
  }

  @override
  void onInit() {
    super.onInit();
    isFavorited(favoriteBooksStore.verifyIfBookIsFavorite(book));
  }
}
