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
  late RxBool isFavorited;

  late final BookEntity book;
  late File _file;
  late SimpleFontelicoProgressDialog _dialog;
  late Dio _dio;

  BookStore({required this.book}) {
    isFavorited = RxBool(false);
  }

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

  Future<void> downloadBook({bool downloadInDownloadsFolder = false}) async {
    final alreadyDownloaded = await verifyIfBookHasDownloaded();
    if (alreadyDownloaded) return;

    try {
      _showProgressDialog('Baixando o livro...');

      await _dio.download(
        _getFormattedDownloadUrl(),
        _file.path,
        deleteOnError: true,
        onReceiveProgress: (received, total) {},
      );

      _dialog.hide();

      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content: Text('Seu livro foi salvo na sua pasta de Downloads!'),
        ),
      );

      await Future.delayed(const Duration(seconds: 2));
    } catch (error) {
      debugPrint('Error downloading book: $error');
    }
  }

  Future<bool> verifyIfBookHasDownloaded() async {
    String downloadsDirectory = await getDownloadFilePath();
    final fileName = book.title.toLowerCase().camelCase!;
    final filePath = '$downloadsDirectory/$fileName.epub';
    _file = File(filePath.replaceAll("'", ""));

    return await _file.exists();
  }

  Future<void> openBook() async {
    try {
      await downloadBook();

      _showProgressDialog('Abrindo seu livro...');

      VocsyEpub.setConfig(
        themeColor: Colors.green,
        scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
        allowSharing: true,
        enableTts: true,
        nightMode: false,
      );

      await Future.delayed(const Duration(seconds: 2));

      VocsyEpub.open(_file.path);

      _dialog.hide();
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

  String _getFormattedDownloadUrl() {
    return book.downloadUrl
        .replaceAll(".images", "")
        .replaceAll(".noimages", "")
        .replaceAll(".epub3", ".epub");
  }

  void _showProgressDialog(String message) {
    _dialog.show(
      message: message,
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
  }

  @override
  void onInit() {
    super.onInit();
    try {
      isFavorited.value = favoriteBooksStore.verifyIfBookIsFavorite(book);
      _dialog = SimpleFontelicoProgressDialog(context: Get.context!);
      _dio = Modular.get<Dio>();
    } catch (error) {
      debugPrint('Error initializing book: $error');
    }
  }
}
