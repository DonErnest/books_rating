import 'package:books_rating/data/book_data.dart';
import 'package:books_rating/models/book.dart';
import 'package:flutter/material.dart';

class BookRating extends StatefulWidget {
  const BookRating({super.key});

  @override
  State<BookRating> createState() => _BookRatingState();
}

class _BookRatingState extends State<BookRating> {
  List<Book> userBooks = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final loadedBooks = await loadBooks();
    setState(() {
      userBooks = loadedBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
