import 'package:books_rating/data/book_data.dart';
import 'package:books_rating/models/book.dart';
import 'package:books_rating/screens/book_detail.dart';
import 'package:books_rating/screens/book_form.dart';
import 'package:books_rating/screens/home.dart';
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

  void addBook(Book newBook) {
    setState(() {
      userBooks.add(newBook);
    });
    saveBooks(userBooks);
  }

  void openAddBoolSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      builder: (ctx) => Wrap(children: [
        BookForm(
          onBookAdded: addBook,
        ),
      ]),
    );
  }

  void browseBook(Book selectedBook) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => BookDetail(
        book: selectedBook,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreen(
        books: userBooks,
        onBrowse: browseBook,
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: openAddBoolSheet,
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
