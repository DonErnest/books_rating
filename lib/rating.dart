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
  final dropDownFilterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final loadedBooks = await loadBooks();
    setState(() {
      userBooks = loadedBooks;
      orderBooks();
    });
  }

  void orderBooks() {
    var thoseWhichAreRead = userBooks
        .where((book) => book.status == ReadingStatus.reading)
        .toList();
    var thoseWhichAreOnShelf = userBooks
        .where((book) => book.status == ReadingStatus.onShelf)
        .toList();
    var thoseWhichAreOnHold =
        userBooks.where((book) => book.status == ReadingStatus.onHold).toList();
    var thoseWhichAreFinished = userBooks
        .where((book) => book.status == ReadingStatus.finished)
        .toList();

    userBooks = thoseWhichAreRead +
        thoseWhichAreOnShelf +
        thoseWhichAreOnHold +
        thoseWhichAreFinished;
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
          onBookEdited: addBook,
        ),
      ]),
    );
  }

  void editBook(Book editedBook) {
    setState(() {
      final idx = userBooks.indexWhere((book) => book.id == editedBook.id);
      userBooks[idx] = editedBook;
    });
  }

  void openEditBookSheet(String id) {
    final existingBook = userBooks.firstWhere((book) => book.id == id);

    showModalBottomSheet(
      context: context,
      builder: (ctx) => BookForm(
        onBookEdited: editBook,
        existingBook: existingBook,
      ),
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

  void removeBook(Book book) {
    setState(() {
      userBooks.remove(book);
    });
  }

  void filterBooks(String? status) async {
    if (status != null) {
      final loadedBooks = await loadBooks();
      if (status == "ALL") {
        setState(() {
          userBooks = loadedBooks;
          orderBooks();
        });
      } else {
        setState(() {
          userBooks = loadedBooks.where((book) => book.status.toString() == status).toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: HomeScreen(
        books: userBooks,
        onBrowse: browseBook,
        onEdit: openEditBookSheet,
        onCancel: removeBook,
      ),
      appBar: AppBar(
        actions: [
          DropdownMenu<String>(
            controller: dropDownFilterController,
            inputDecorationTheme: theme.inputDecorationTheme,
            dropdownMenuEntries: [
                  DropdownMenuEntry(value: "ALL", label: "Все"),
                ] +
                ReadingStatus.values
                    .map<DropdownMenuEntry<String>>((status) =>
                        DropdownMenuEntry(
                            value: status.toString(),
                            label: status.displayStatus))
                    .toList(),
            onSelected: filterBooks,
          ),
          IconButton(
            onPressed: openAddBoolSheet,
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
