import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum ReadingStatus {
  onShelf("На полке"),
  reading("Читаю"),
  finished("Прочитано"),
  onHold("Отложено");

  final String displayStatus;

  const ReadingStatus(this.displayStatus);
}

class Book {
  late final String id;
  final String author;
  final String name;
  final int genreId;
  final int pageCount;
  final ReadingStatus status;
  final DateTime? finishedOn;
  final int? rate;

  Book({String? id,
    required this.author,
    required this.name,
    required this.genreId,
    required this.pageCount,
    required this.status,
    this.finishedOn,
    this.rate})
      : id = id ?? uuid.v4();

  String get displayInfo => "${this.name}";
}
