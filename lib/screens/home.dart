import 'package:books_rating/models/book.dart';
import 'package:books_rating/widgets/book_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatelessWidget {
  final List<Book> books;
  final void Function(Book book) onBrowse;
  final void Function(String id) onEdit;
  final void Function(Book book) onCancel;

  const HomeScreen(
      {super.key,
      required this.books,
      required this.onBrowse,
      required this.onEdit,
      required this.onCancel});

  int get readThisYear => books
      .where((book) =>
          book.status == ReadingStatus.finished &&
          DateTime.now().difference(book.finishedOn!).inDays <
              Duration(days: 365).inDays)
      .length;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var counterText =
        "Вы прочитали ${readThisYear} из ${maxCount} в этом году. Слабенько";

    if (readThisYear >= maxCount) {
      counterText = "Вы действительно прочитали столько или льстите себе? \n😏";
    }

    return Column(
      children: [
        Text(
          counterText,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: readThisYear >= maxCount
                  ? Colors.green.shade800
                  : Colors.black),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, idx) => Slidable(
              endActionPane: ActionPane(
                motion: DrawerMotion(),
                children: [
                  SlidableAction(
                    onPressed: (ctx) => onCancel(books[idx]),
                    icon: Icons.delete,
                    backgroundColor: theme.colorScheme.error.withAlpha(220),
                    label: 'Delete',
                  ),
                  SlidableAction(
                    onPressed: (ctx) => onEdit(books[idx].id),
                    icon: Icons.edit,
                    backgroundColor: theme.colorScheme.secondary.withAlpha(220),
                    label: 'Edit',
                  ),
                ],
              ),
              child: BookRow(
                book: books[idx],
                browseBookInfo: onBrowse,
              ),
            ),
            itemCount: books.length,
          ),
        ),
      ],
    );
  }
}
