import 'dart:async';
import 'dart:io';

import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/favorite_books_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

import 'package:path_provider/path_provider.dart';

extension on String {
  normalize() {
    return replaceAll(" ", "+");
  }
}

class BookStore extends GetxController {
  final FavoriteBooksStore favoriteBooksStore = Get.find<FavoriteBooksStore>();
  RxBool isFavorited = RxBool(false);

  final BookEntity book;
  File? file;

  BookStore({required this.book});

  Future<void> addToFavoriteBooks() async {
    favoriteBooksStore.addToFavoriteBooks(book);
    isFavorited(true);
  }

  Future<void> removeFromFavoriteBooks() async {
    favoriteBooksStore.removeFromFavoriteBooks(book);
    isFavorited(false);
  }

  Future<void> downloadBook({required BuildContext context}) async {
    String fileName = book.title.toLowerCase().camelCase!;
    final Dio dio = Modular.get();

    Directory? appDocDir;

    if (Platform.isIOS) {
      appDocDir = await getApplicationDocumentsDirectory();
    } else {
      appDocDir = Directory('/storage/emulated/0/Download');
      if (!await appDocDir.exists()) {
        appDocDir = await getExternalStorageDirectory();
      }
    }

    String path = '${appDocDir!.path}/$fileName.epub';
    file = File(path);

    if (!File(path).existsSync()) {
      await file!.create();
      await dio
          .download(
            book.downloadUrl
                .replaceAll(".images", "")
                .replaceAll(".noimages", "")
                .replaceAll(".epub3", ".epub"),
            path,
            deleteOnError: true,
            onReceiveProgress: (receivedBytes, totalBytes) {},
          )
          .whenComplete(() {});
    }
  }

  Future<void> openBook({required BuildContext context}) async {
    if (file == null) {
      await downloadBook(context: context);
    }

    VocsyEpub.setConfig(
      themeColor: Colors.green,
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
    );

    VocsyEpub.open(
      file!.path,
    );
  }

  @override
  void onInit() {
    super.onInit();
    isFavorited(favoriteBooksStore.verifyIfBookIsFavorite(book));
  }
}
