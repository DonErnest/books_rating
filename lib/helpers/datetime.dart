import 'package:flutter/material.dart';

String _zeroPad(int dateTimeValue) {
  if (dateTimeValue < 10) {
    return '0$dateTimeValue';
  }
  return dateTimeValue.toString();
}

String formatDateTime(DateTime dateTime) {
  final day = _zeroPad(dateTime.day);
  final month = _zeroPad(dateTime.month);
  final year = dateTime.year;
  final hour = _zeroPad(dateTime.hour);
  final minute = _zeroPad(dateTime.minute);
  return '$day.$month.$year $hour:$minute';
}

String formatDate(DateTime dateTime) {
  final day = _zeroPad(dateTime.day);
  final month = _zeroPad(dateTime.month);
  final year = dateTime.year;
  return '$day.$month.$year';
}

String formatTime(TimeOfDay dateTime) {
  final hour = _zeroPad(dateTime.hour);
  final minute = _zeroPad(dateTime.minute);

  return '$hour:$minute';
}