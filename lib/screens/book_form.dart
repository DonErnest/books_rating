import 'package:books_rating/helpers/datetime.dart';
import 'package:books_rating/models/book.dart';
import 'package:books_rating/models/genre.dart';
import 'package:flutter/material.dart';

class BookForm extends StatefulWidget {
  final void Function(Book book) onBookAdded;

  const BookForm({super.key, required this.onBookAdded});

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  var bookAuthor = "";
  final bookAuthorController = TextEditingController();

  var bookName = "";
  final bookNameController = TextEditingController();

  Genre? bookGenre;
  final bookGenreController = TextEditingController();

  int bookPageCount = 0;
  final bookPageCountController = TextEditingController();

  ReadingStatus bookStatus = ReadingStatus.onShelf;
  final bookStatusController = TextEditingController();

  DateTime? bookFinishedOnDate;
  final bookFinishedOnDateController = TextEditingController();

  TimeOfDay? bookFinishedOnTime;
  final bookFinishedOnTimeController = TextEditingController();

  int? bookRating;
  final bookRatingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void onCanceled() {
    Navigator.pop(context);
  }

  void onSaved() {
    setState(() {
      if (bookAuthor == "" ||
          bookName == "" ||
          bookGenre == null ||
          bookPageCount == 0) {
        return;
      }
      DateTime? dateTime;
      if (bookFinishedOnDate != null && bookFinishedOnTime != null) {
        dateTime = DateTime(
          bookFinishedOnDate!.year,
          bookFinishedOnDate!.month,
          bookFinishedOnDate!.day,
          bookFinishedOnTime!.hour,
          bookFinishedOnTime!.minute,
        );
      }

      final book = Book(
        author: bookAuthor,
        name: bookName,
        genreId: bookGenre!.id,
        pageCount: bookPageCount,
        status: bookStatus,
        finishedOn: dateTime,
        rate: bookRating,
      );
      widget.onBookAdded(book);
      Navigator.pop(context);
    });
  }

  void onDateTap() async {
    final now = DateTime.now();
    // it's better not to plan task for more than 2 week sprint
    final lastDate = DateTime(now.year, now.month, now.day + 14);

    final dateFromUser = await showDatePicker(
      context: context,
      initialDate: bookFinishedOnDate,
      firstDate: now,
      lastDate: lastDate,
    );

    if (dateFromUser != null) {
      setState(() {
        bookFinishedOnDate = dateFromUser;
        bookFinishedOnDateController.text = formatDate(dateFromUser);
      });
    }
  }

  void onTimeTap() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: bookFinishedOnTime != null? bookFinishedOnTime! : TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        bookFinishedOnTime = pickedTime;
        bookFinishedOnTimeController.text = formatTime(pickedTime);
      });
    }
  }

  @override
  void dispose() {
    bookAuthorController.dispose();
    bookNameController.dispose();
    bookStatusController.dispose();
    bookGenreController.dispose();
    bookPageCountController.dispose();
    bookFinishedOnDateController.dispose();
    bookFinishedOnTimeController.dispose();
    bookRatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(16, 16, 16, bottomInset + 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: bookAuthorController,
              onChanged: (value) => setState(() => bookAuthor = value),
              maxLines: 1,
              decoration: const InputDecoration(
                label: Text("enter book author"),
              ),
            ),
            TextField(
              controller: bookNameController,
              onChanged: (value) => setState(() => bookName = value),
              maxLines: 1,
              decoration: const InputDecoration(
                label: Text("enter book name"),
              ),
            ),
            DropdownMenu(
              expandedInsets: EdgeInsets.zero,
              label: Text("Genre"),
              inputDecorationTheme: theme.inputDecorationTheme,
              dropdownMenuEntries: allGenres
                  .map(
                    (genre) => DropdownMenuEntry(
                  value: genre.id,
                  label: genre.name,
                ),
              )
                  .toList(),
              onSelected: (value) => setState(() {
                value != null? bookGenre = getGenreById(value) : null;
              }),
              controller: bookGenreController,
            ),
            TextField(
              controller: bookPageCountController,
              onChanged: (value) => setState(() => bookPageCount = int.parse(value)),
              maxLines: 1,
              decoration: const InputDecoration(
                label: Text("Количество страниц"),
              ),
            ),
            DropdownMenu(
              expandedInsets: EdgeInsets.zero,
              label: Text("Статус"),
              inputDecorationTheme: theme.inputDecorationTheme,
              dropdownMenuEntries: ReadingStatus.values
                  .map(
                    (status) => DropdownMenuEntry(
                  value: status,
                  label: status.displayStatus,
                ),
              )
                  .toList(),
              onSelected: (value) => setState(() {
                value = bookStatus;
              }),
              controller: bookGenreController,
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    onTap: onDateTap,
                    readOnly: true,
                    controller: bookFinishedOnDateController,
                    decoration: InputDecoration(
                      label: Text('Дата прочтения'),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                SizedBox(
                  width: 100,
                  child: TextField(
                    onTap: onTimeTap,
                    readOnly: true,
                    controller: bookFinishedOnTimeController,
                    decoration: InputDecoration(
                      label: Text('Время прочтения'),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                TextButton(onPressed: onCanceled, child: Text('Отмена')),
                const Spacer(),
                ElevatedButton(
                  onPressed: onSaved,
                  child: const Text("Сохранить"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
