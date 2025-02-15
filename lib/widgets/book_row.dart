import 'package:books_rating/helpers/datetime.dart';
import 'package:books_rating/models/book.dart';
import 'package:flutter/material.dart';

class BookRow extends StatelessWidget {
  final Book book;
  final void Function(Book book) browseBookInfo;

  const BookRow({super.key, required this.book, required this.browseBookInfo});

  @override
  Widget build(BuildContext context) {
    var coreInfo = [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            book.displayInfo,
            style: Theme.of(context).textTheme.titleMedium,
          )
        ],
      ),
      Row(
        children: [Spacer(), Text(book.author)],
      ),
      Row(
        children: [Spacer(), Text(book.status.displayStatus)],
      )
    ];

    if (book.status == ReadingStatus.finished) {
      coreInfo.add(Row(
        children: [Spacer(), Text("Закончена ${formatDate(book.finishedOn!)}")],
      ));
    }

    return GestureDetector(
      onTap: () => browseBookInfo(book),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue.shade900),
          ),
          child: Column(
            children: coreInfo,
          ),
        ),
      ),
    );
  }
}
