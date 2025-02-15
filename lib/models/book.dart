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

ReadingStatus getStatusFromString(String statusAsString) {
  for (var status in ReadingStatus.values) {
    if (status.toString() == statusAsString) {
      return status;
    }
  }
  return ReadingStatus.onShelf;
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
