import 'package:books_rating/helpers/datetime.dart';
import 'package:books_rating/models/book.dart';
import 'package:books_rating/models/genre.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookForm extends StatefulWidget {
  final void Function(Book book) onBookEdited;
  final Book? existingBook;

  const BookForm({super.key, required this.onBookEdited, this.existingBook});

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
  Set<int> _bookRatingButtonSelection = <int>{};

  @override
  void initState() {
    super.initState();

    if (widget.existingBook != null) {
      final existingBook = widget.existingBook!;

      bookAuthorController.text = existingBook.author;
      bookAuthor = existingBook.author;

      bookNameController.text = existingBook.name;
      bookName = existingBook.name;

      bookPageCountController.text = existingBook.pageCount.toString();
      bookPageCount = existingBook.pageCount;

      bookStatusController.text = existingBook.status.displayStatus;
      bookStatus = existingBook.status;

      bookGenreController.text = getGenreById(existingBook.genreId).name;
      bookGenre = getGenreById(existingBook.genreId);

      existingBook.rate != null
          ? _bookRatingButtonSelection = {existingBook.rate!}
          : <int>{};

      bookFinishedOnDate = existingBook.finishedOn;
      if (bookFinishedOnDate != null) {
        bookFinishedOnTime = TimeOfDay.fromDateTime(bookFinishedOnDate!);
      }
    }
    if (bookFinishedOnDate != null) {
      bookFinishedOnDateController.text = formatDate(bookFinishedOnDate!);
      bookFinishedOnTimeController.text = formatTime(bookFinishedOnTime!);
    }
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
      if (bookStatus == ReadingStatus.finished &&
          (bookFinishedOnDate == null || bookFinishedOnTime == null)) {
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

      // if user decides to change status of finished book, it's better to flush rating then
      int? bookRating;
      if (bookStatus != ReadingStatus.finished) {
        bookRating = null;
        dateTime = null;
      } else {
        bookRating = _bookRatingButtonSelection.isNotEmpty
            ? _bookRatingButtonSelection.first
            : null;
      }

      final book = Book(
        id: widget.existingBook?.id,
        author: bookAuthorController.text.trim(),
        name: bookNameController.text.trim(),
        genreId: bookGenre!.id,
        pageCount: int.parse(bookPageCountController.text),
        status: bookStatus,
        finishedOn: dateTime,
        rate: bookRating,
      );

      widget.onBookEdited(book);
      Navigator.pop(context);
    });
  }

  void onDateTap() async {
    final now = DateTime.now();

    final dateFromUser = await showDatePicker(
      context: context,
      initialDate: bookFinishedOnDate,
      firstDate: now.subtract(Duration(days: 365 * 10)),
      lastDate: now,
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
      initialTime:
          bookFinishedOnTime != null ? bookFinishedOnTime! : TimeOfDay.now(),
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
                value != null ? bookGenre = getGenreById(value) : null;
              }),
              controller: bookGenreController,
            ),
            TextField(
              controller: bookPageCountController,
              onChanged: (value) =>
                  setState(() => bookPageCount = int.parse(value)),
              maxLines: 1,
              decoration: const InputDecoration(
                label: Text("Количество страниц"),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
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
                bookStatus = value!;
              }),
              controller: bookStatusController,
            ),
            IgnorePointer(
              ignoring: bookStatus == ReadingStatus.finished ? false : true,
              child: Row(
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
            ),
            IgnorePointer(
              ignoring: bookStatus == ReadingStatus.finished ? false : true,
              child: SegmentedButton<int>(
                segments: [1, 2, 3, 4, 5]
                    .map<ButtonSegment<int>>((value) => ButtonSegment(
                        value: value, label: Text(value.toString())))
                    .toList(),
                selected: _bookRatingButtonSelection,
                multiSelectionEnabled: false,
                emptySelectionAllowed: true,
                onSelectionChanged: (newSelection) {
                  setState(() {
                    _bookRatingButtonSelection = newSelection;
                  });
                },
              ),
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
