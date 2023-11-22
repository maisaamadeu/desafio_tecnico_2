import 'dart:async';
import 'dart:io';

import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/favorite_books_store.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';
import 'package:path_provider/path_provider.dart';

class BookStore extends GetxController {
  final FavoriteBooksStore favoriteBooksStore = Get.find<FavoriteBooksStore>();
  RxBool isFavorited = RxBool(false);

  final BookEntity book;
  final BuildContext context;
  File? file;

  RxDouble receivedBytes = 0.0.obs;
  RxDouble totalBytes = 0.0.obs;

  BookStore(this.context, {required this.book});

  Future<void> addToFavoriteBooks() async {
    favoriteBooksStore.addToFavoriteBooks(book);
    isFavorited(true);
  }

  Future<void> removeFromFavoriteBooks() async {
    favoriteBooksStore.removeFromFavoriteBooks(book);
    isFavorited(false);
  }

  Future<void> downloadBook() async {
    final Dio dio = Modular.get();

    try {
      await file!.create();
      String correctedDownloadUrl = book.downloadUrl
          .replaceAll(".images", "")
          .replaceAll(".noimages", "")
          .replaceAll(".epub3", ".epub");

      SimpleFontelicoProgressDialog _dialog =
          SimpleFontelicoProgressDialog(context: context);

      _dialog.show(
        message: 'Baixando o livro...',
        type: SimpleFontelicoProgressDialogType.normal,
        elevation: 1,
        horizontal: true,
        width: 300,
        indicatorColor: Colors.green,
        textStyle: GoogleFonts.inter(
          fontSize: 18,
        ),
        separation: 20,
      );

      await dio.download(
        correctedDownloadUrl,
        file!.path,
        deleteOnError: true,
        onReceiveProgress: (receivedBytes, totalBytes) {
          receivedBytes = receivedBytes;
          totalBytes = totalBytes;
        },
      );

      _dialog.hide();
    } catch (error) {
      return;
    }
  }

  Future<bool> verifyIfBookHasDownloaded() async {
    String fileName = book.title.toLowerCase().camelCase!;

    Directory? appDocDir;

    if (Platform.isIOS) {
      appDocDir = await getApplicationDocumentsDirectory();
    } else {
      appDocDir = Directory('/storage/emulated/0/Download');
      if (!await appDocDir.exists()) {
        appDocDir = await getExternalStorageDirectory();
      }
    }

    String filePath = '${appDocDir!.path}/$fileName.epub';
    file = File(filePath);

    if (!file!.existsSync()) {
      return false;
    }

    return true;
  }

  Future<void> openBook() async {
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
