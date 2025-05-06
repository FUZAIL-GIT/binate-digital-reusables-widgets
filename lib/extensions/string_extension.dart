import 'package:flutter/material.dart';

extension TimeOfDayFormatter on TimeOfDay {
  String format12Hour() {
    return '$hourOfPeriod : ${minute.toString().padLeft(2, '0')} ${period == DayPeriod.am ? 'AM' : 'PM'}';
  }
}

extension StringCapitalization on String {
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }
}
