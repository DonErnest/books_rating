import 'package:books_rating/models/book.dart';
import 'package:flutter/material.dart';

class BookRow extends StatelessWidget {
  final Book book;

  const BookRow({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: Container(
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.start,children: [Text(book.displayInfo)],),
            Row(children: [Text(book.author)],),
            Row(children: [Text(book.status.displayStatus)],)
          ],
        ),
      ),
    );
  }
}
