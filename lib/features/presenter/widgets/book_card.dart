import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/presenter/stores/book_store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bookStore.openBook(context: context);
      },
      child: Container(
        margin: EdgeInsets.only(left: marginLeft ?? 0, right: marginRight ?? 0),
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
