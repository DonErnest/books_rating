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
      child: Column(
        children: [
          Row(
            children: [Expanded(child: Text("Автор")), Spacer(), Expanded(child: Text(book.author))],
          ),
          Row(
            children: [Expanded(child: Text("Название")), Spacer(), Expanded(child: Text(book.name))],
          ),
          Row(
            children: [Expanded(child: Text("Жанр")), Spacer(), Expanded(child: Text(getGenreById(book.genreId).name))],
          ),
          Row(
            children: [Expanded(child: Text("Статус")), Spacer(), Expanded(child: Text(book.status.displayStatus))],
          ),
          Row(
            children: [Expanded(child: Text("Прочтена")), Spacer(), Expanded(child: Text(book.finishedOn != null? formatDateTime(book.finishedOn!): "не прочтена"))],
          ),
          Row(
            children: [Expanded(child: Text("Оценка")), Spacer(), Expanded(child: Text(book.rate != null? book.rate.toString() : "нет оценки"))],
          ),
        ],
      ),
    );
  }
}
