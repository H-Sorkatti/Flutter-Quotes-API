import 'dart:ffi';

class Quotes {
  final String id;
  final List<dynamic> tags;
  final String content;
  final String author;
  final String authorSlug;
  final int length;
  final String dateAdded;
  final String dateModified;

  Quotes(
      {required this.id,
      required this.tags,
      required this.content,
      required this.author,
      required this.authorSlug,
      required this.length,
      required this.dateAdded,
      required this.dateModified});

  Quotes.fromJSON(Map json)
      : id = json['_id'],
        tags = json['tags'],
        content = json['content'],
        author = json['author'],
        authorSlug = json['authorSlug'],
        length = json['length'],
        dateAdded = json['dateAdded'],
        dateModified = json['dateModified'];
}