import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,
    this.height,
    this.width,
    this.marginLeft,
    this.marginRight,
  });

  final BookEntity book;
  final double? height;
  final double? width;
  final double? marginLeft;
  final double? marginRight;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onLongPress: () {},
      child: Container(
        height: height ?? 300,
        width: width ?? 250,
        margin: EdgeInsets.only(left: marginLeft ?? 0, right: marginRight ?? 0),
        child: Stack(
          children: [
            // Exibe um indicativo de que está carregando enquanto a imagem não aparece
            const Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              right: 0,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),

            // Exibe a imagem da semente (ou uma imagem padrão se não houver imagem disponível)
            Positioned.fill(
              left: 0,
              top: 0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(book.coverUrl),
              ),
            ),

            // Adiciona uma sobreposição escura à imagem
            Positioned.fill(
              left: 0,
              top: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
            // Exibe o nome e a posição da semente
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome da semente
                  Text(
                    book.title,
                    style: GoogleFonts.alegreya(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Posição da semente
                  Text(
                    'Autor: ${book.author}',
                    style: GoogleFonts.alegreyaSans(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
