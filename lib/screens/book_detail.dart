import 'package:books_rating/helpers/datetime.dart';
import 'package:books_rating/models/book.dart';
import 'package:books_rating/models/genre.dart';
import 'package:flutter/material.dart';

class BookDetail extends StatelessWidget {
  final Book book;

  const BookDetail({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                  child: Text(
                "Автор",
                style: Theme.of(context).textTheme.titleLarge,
              )),
              Expanded(
                flex: 2,
                  child: Text(
                book.author,
                style: Theme.of(context).textTheme.titleLarge,
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                flex: 1,
                  child: Text(
                "Название",
                style: Theme.of(context).textTheme.titleLarge,
              )),
              Expanded(
                flex: 2,
                  child: Text(
                book.name,
                style: Theme.of(context).textTheme.titleLarge,
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                flex: 1,
                  child: Text(
                "Жанр",
                style: Theme.of(context).textTheme.titleLarge,
              )),
              Expanded(
                flex: 2,
                  child: Text(
                getGenreById(book.genreId).name,
                style: Theme.of(context).textTheme.titleLarge,
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                flex: 1,
                  child: Text(
                "Статус",
                style: Theme.of(context).textTheme.titleLarge,
              )),
              Expanded(
                flex: 2,
                  child: Text(
                book.status.displayStatus,
                style: Theme.of(context).textTheme.titleLarge,
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                flex: 1,
                  child: Text(
                "Прочтена",
                style: Theme.of(context).textTheme.titleLarge,
              )),
              Expanded(
                flex: 2,
                  child: Text(
                book.finishedOn != null
                    ? formatDateTime(book.finishedOn!)
                    : "не прочтена",
                style: Theme.of(context).textTheme.titleLarge,
              ))
            ],
          ),
          Divider(),
          Row(
            children: [
              Expanded(
                flex: 1,
                  child: Text(
                "Оценка",
                style: Theme.of(context).textTheme.titleLarge,
              )),
              Expanded(
                flex: 2,
                  child: Text(
                book.rate != null ? book.rate.toString() : "нет оценки",
                style: Theme.of(context).textTheme.titleLarge,
              ))
            ],
          ),
        ],
      ),
    );
  }
}
