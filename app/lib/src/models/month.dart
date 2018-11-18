import 'package:intl/intl.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'month.g.dart';

abstract class Month implements Built<Month, MonthBuilder>, Comparable<Month> {
  int get month;
  int get year;

  Month add(int months) {
    DateTime result = DateTime(year, month + months);
    return Month.fromDate(result);
  }

  Month subtract(int months) {
    DateTime result = DateTime(year, month - months);
    return Month.fromDate(result);
  }

  @override
  String toString() {
    return DateFormat("MMM / yy").format(DateTime(year, month)).toUpperCase();
  }

  static Month now() {
    return Month.fromDate(DateTime.now());
  }

  static fromDate(DateTime date) {
    return Month((b) => b
      ..year = date.year
      ..month = date.month);
  }

  static detailed(int month, int year) {
    return Month((b) => b
      ..year = year
      ..month = month);
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

  Month._();
  factory Month([updates(MonthBuilder b)]) = _$Month;

  static Serializer<Month> get serializer => _$monthSerializer;
}
