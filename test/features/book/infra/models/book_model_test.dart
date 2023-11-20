import 'dart:convert';

import 'package:desafio_tecnico_2/features/book/domain/entities/book_entity.dart';
import 'package:desafio_tecnico_2/features/book/infra/models/book_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../mocks/book_mock.dart';

void main() {
  final tBookModel = BookModel(
    id: 4,
    title: "Lupe",
    author: "Affonso Celso",
    coverUrl:
        "https://www.gutenberg.org/cache/epub/63606/pg63606.cover.medium.jpg",
    downloadUrl: "https://www.gutenberg.org/ebooks/63606.epub3.images",
  );

  test('should be a subclass of BookEntity', () {
    expect(tBookModel, isA<BookEntity>());
  });

  test('should return a valid model', () async {
    final Map<String, dynamic> jsonMap = json.decode(bookMock);
    final result = BookModel.fromJson(jsonMap);
    expect(result, tBookModel);
  });

  test('should return a json map containing the props data', () async {
    final expectedMap = {
      "id": 4,
      "title": "Lupe",
      "author": "Affonso Celso",
      "cover_url":
          "https://www.gutenberg.org/cache/epub/63606/pg63606.cover.medium.jpg",
      "download_url": "https://www.gutenberg.org/ebooks/63606.epub3.images",
    };
    final result = tBookModel.toJson();
    expect(expectedMap, result);
  });
}
