import 'package:intl/intl.dart';

class Month implements Comparable<Month> {
  final int month;
  final int year;
  DateFormat _formater = DateFormat("MMM / yy");

  Month(this.month, this.year);

  Month.now()
      : month = 10,
        year = 2018;

  Month add(int months) {
    DateTime result = DateTime(year, month + months);
    return Month(result.month, result.year);
  }

  Month subtract(int months) {
    DateTime result = DateTime(year, month - months);
    return Month(result.month, result.year);
  }

  @override
  String toString() {
    return _formater.format(DateTime(year, month)).toUpperCase();
  }

  String formatString(DateFormat formater) {
    return formater.format(DateTime(year, month)).toUpperCase();
  }

  static fromDate(DateTime date) {
    return Month(date.month, date.year);
  }

  @override
  int compareTo(Month other) {
    if ((year < other.year) || (year == other.year && month < other.month))
      return -1;

    if ((year == other.year) && (month == other.month)) return 0;

    if ((year > other.year) || (year == other.year && month > other.month))
      return 1;

    return 0;
  }
}
