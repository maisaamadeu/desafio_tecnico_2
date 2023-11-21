import 'package:desafio_tecnico_2/features/domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  const BookModel({
    required super.id,
    required super.title,
    required super.author,
    required super.coverUrl,
    required super.downloadUrl,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
        id: json["id"],
        title: json['title'],
        author: json['author'],
        coverUrl: json['cover_url'],
        downloadUrl: json['download_url'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'cover_url': coverUrl,
        'download_url': downloadUrl,
      };

  factory BookModel.fromBookEntity(BookEntity entity) => BookModel(
        id: entity.id,
        title: entity.title,
        author: entity.author,
        coverUrl: entity.coverUrl,
        downloadUrl: entity.downloadUrl,
      );
}
