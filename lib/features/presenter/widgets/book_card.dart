// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/book_store.dart';
import 'package:desafio_tecnico_2/features/presenter/widgets/custom_alert_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    this.height,
    this.width,
    this.marginLeft,
    this.marginRight,
    required this.bookStore,
  });

  final BookStore bookStore;

  final BookEntity book;
  final double? height;
  final double? width;
  final double? marginLeft;
  final double? marginRight;

  Future<bool> _requestStoragePermission(BuildContext context) async {
    final androidVersion = await DeviceInfoPlugin().androidInfo;

    if ((androidVersion.version.sdkInt) >= 30) {
      return await checkManageStoragePermission(context);
    } else {
      return await checkStoragePermission(context);
    }
  }

  static Future<bool> checkManageStoragePermission(BuildContext context) async {
    return (await Permission.manageExternalStorage.isGranted ||
        await Permission.manageExternalStorage.request().isGranted);
  }

  static Future<bool> checkStoragePermission(BuildContext context,
      {String? storageTitle, String? storageSubMessage}) async {
    if (await Permission.storage.isGranted ||
        await Permission.storage.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        bool result = await _requestStoragePermission(context);
        if (result) {
          bookStore.openBook();
        } else {
          showDialog(
            context: context,
            builder: (_) => CustomAlertDialog().showCustomAlertDialog(
              title: 'Autorização Negada',
              icon: const Icon(
                Icons.close,
                color: Colors.red,
                size: 96,
              ),
              content:
                  'Você recusou a autorização para acessar o armazenamento do dispositivo, impedindo o aplicativo de baixar e abrir livros. Para resolver, acesse as configurações do aplicativo e conceda permissão de acesso ao armazenamento.',
              actions: [
                TextButton(
                  onPressed: () {
                    openAppSettings();
                  },
                  child: const Text(
                    'ABRIR CONFIGURAÇÕES',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'DEPOIS',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        // await bookStore.openBook();
      },
      child: Ink(
        child: Container(
          margin:
              EdgeInsets.only(left: marginLeft ?? 0, right: marginRight ?? 0),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: book.coverUrl,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: Colors.green,
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageBuilder: (context, imageProvider) => Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadiusDirectional.circular(10),
                      child: Image(
                        image: imageProvider,
                      ),
                    ),
                    Obx(
                      () => Positioned(
                        right: 0,
                        child: IconButton(
                          icon: Icon(
                            Icons.bookmark,
                            color: bookStore.isFavorited.value
                                ? Colors.red
                                : Colors.white,
                            size: 48,
                            shadows: const <Shadow>[
                              Shadow(
                                color: Colors.black54,
                                blurRadius: 20.0,
                              )
                            ],
                          ),
                          onPressed: () async {
                            if (bookStore.isFavorited.value) {
                              bookStore.removeFromFavoriteBooks();
                            } else {
                              bookStore.addToFavoriteBooks();
                            }
                          },
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    book.title,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    book.author,
                    style: GoogleFonts.inter(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
