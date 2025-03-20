import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  return DateFormat('dd MMM yyyy').format(dateTime);
}
String formatDateTimeFromString(String dateString) {
  try {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd MMM yyyy').format(dateTime);
  } catch (e) {
    debugPrint("Error parsing date: $e");
    return "Invalid Date";
  }
}