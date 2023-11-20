class BookEntity {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;

  BookEntity({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.downloadUrl,
  });
}
