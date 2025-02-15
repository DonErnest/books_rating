import 'dart:convert';
import 'dart:io';

import 'package:books_rating/helpers/get_data_file_path.dart';
import 'package:books_rating/models/book.dart';



Future<void> saveBooks(List<Book> books) async {
  final filePath = await getDataFilePath("books");
  final file = File(filePath);
  final booksMaps = books.map(
      (book) => {
        'id': book.id,
        'author': book.author,
        'name': book.name,
        'genreId': book.genreId,
        'pageCount': book.pageCount,
        'status': book.status.toString(),
        'rate': book.rate,
        'finishedOn': book.finishedOn?.toIso8601String(),
    }
  ).toList();
  final booksJson = jsonEncode(booksMaps);
  await file.writeAsString(booksJson);
}

Future<List<Book>> loadBooks() async {
  try {
    final filePath = await getDataFilePath("books");
    final file = File(filePath);
    final jsonContents = await file.readAsString();
    final booksMaps = jsonDecode(jsonContents) as List<dynamic>;
    return booksMaps.map(
        (bookMap) => Book(
          id: bookMap["id"],
          author: bookMap["author"],
          name: bookMap["name"],
          genreId: bookMap["genreId"],
          pageCount: bookMap["pageCount"],
          status: getStatusFromString(bookMap["status"]),
          finishedOn: bookMap["finishedOn"] != null ? DateTime.parse(bookMap["finishedOn"]) : null,
          rate: bookMap["rate"]
        )
    ).toList();
  } catch (error) {
    return [];
  }
}
