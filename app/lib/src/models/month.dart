import 'package:intl/intl.dart';

class Month {
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
}
