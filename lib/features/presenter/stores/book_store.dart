// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/favorite_books_store.dart';

class BookStore extends GetxController {
  final FavoriteBooksStore favoriteBooksStore = Get.find<FavoriteBooksStore>();
  RxBool isFavorited = RxBool(false);

  final BookEntity book;
  final BuildContext context;
  late File file;
  late SimpleFontelicoProgressDialog dialog;

  BookStore(this.context, {required this.book});

  Future<void> addToFavoriteBooks() async {
    try {
      favoriteBooksStore.addToFavoriteBooks(book);
      isFavorited(true);
    } catch (error) {
      debugPrint('Error adding to favorite books: $error');
    }
  }

  Future<void> removeFromFavoriteBooks() async {
    try {
      favoriteBooksStore.removeFromFavoriteBooks(book);
      isFavorited(false);
    } catch (error) {
      debugPrint('Error removing from favorite books: $error');
    }
  }

  Future<void> downloadBook() async {
    final alreadyDownloaded = await verifyIfBookHasDownloaded();
    if (alreadyDownloaded) return;

    final Dio dio = Modular.get();

    try {
      dialog.show(
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
        book.downloadUrl
            .replaceAll(".images", "")
            .replaceAll(".noimages", "")
            .replaceAll(".epub3", ".epub"),
        file.path,
        deleteOnError: true,
        onReceiveProgress: (received, total) {},
      );

      dialog.hide();

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Seu livro foi baixado na sua pasta de Downloads!')));

      Future.delayed(const Duration(seconds: 2));
    } catch (error) {
      debugPrint('Error downloading book: $error');
    }
  }

  Future<bool> verifyIfBookHasDownloaded() async {
    String downloadsDirectory = await getDownloadFilePath();
    final fileName = book.title.toLowerCase().camelCase!;
    final filePath = '$downloadsDirectory/$fileName.epub';
    file = File(filePath.replaceAll("'", ""));

    return await file.exists();
  }

  Future<void> openBook() async {
    try {
      await downloadBook();

      dialog.show(
        message: 'Abrindo seu livro...',
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

      VocsyEpub.setConfig(
        themeColor: Colors.green,
        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      );

      VocsyEpub.open(file.path);

      dialog.hide();
    } catch (error) {
      debugPrint('Error opening book: $error');
    }
  }

  Future<String> getDownloadFilePath() async {
    final appDocDir = Platform.isIOS
        ? await getApplicationDocumentsDirectory()
        : Directory('/storage/emulated/0/Download');
    return appDocDir.path;
  }

  @override
  void onInit() {
    super.onInit();
    try {
      isFavorited(favoriteBooksStore.verifyIfBookIsFavorite(book));
      dialog = SimpleFontelicoProgressDialog(context: context);
    } catch (error) {
      debugPrint('Error initializing book: $error');
    }
  }
}
