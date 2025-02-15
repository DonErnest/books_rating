import 'package:books_rating/models/book.dart';
import 'package:books_rating/widgets/book_row.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final List<Book> books;
  final void Function(Book book) onBrowse;

  const HomeScreen({super.key, required this.books, required this.onBrowse});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, idx) => BookRow(
        book: books[idx],
        browseBookInfo: onBrowse,
      ),
      itemCount: books.length,
    );
  }
}
