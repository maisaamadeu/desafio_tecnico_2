import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/book_store.dart';
import 'package:desafio_tecnico_2/features/presenter/widgets/custom_alert_dialog.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.book,
    required this.bookStore,
  }) : super(key: key);

  final BookStore bookStore;
  final BookEntity book;

  Future<bool> _requestStoragePermission() async {
    final androidVersion = await DeviceInfoPlugin().androidInfo;

    if ((androidVersion.version.sdkInt) >= 30) {
      return await checkManageStoragePermission();
    } else {
      return await checkStoragePermission();
    }
  }

  static Future<bool> checkManageStoragePermission() async {
    return await Permission.manageExternalStorage.isGranted ||
        await Permission.manageExternalStorage.request().isGranted;
  }

  static Future<bool> checkStoragePermission() async {
    return await Permission.storage.isGranted ||
        await Permission.storage.request().isGranted;
  }

  Future<void> _showPermissionDeniedDialog() async {
    showDialog(
      context: Get.context!,
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
              Navigator.pop(Get.context!);
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

  Future<void> _onCardTap(BuildContext context) async {
    bool result = await _requestStoragePermission();
    if (result) {
      bookStore.openBook();
    } else {
      _showPermissionDeniedDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onCardTap(context),
      child: Ink(
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
    );
  }
}
