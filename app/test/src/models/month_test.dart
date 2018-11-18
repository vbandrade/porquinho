import 'package:flutter_test/flutter_test.dart';
import 'package:app/src/models/month.dart';

void main() {
  group("Test Month operations", () {
    test("adding 1 month on december should increase year", () {
      final startMonth = Month(12, 2018);
      final result = startMonth.add(1);

      expect(result.month, 1);
      expect(result.year, 2019);
    });
    test("subtracting 1 month on january should reduce year", () {
      final startMonth = Month(1, 2018);
      final result = startMonth.subtract(1);

      expect(result.month, 12);
      expect(result.year, 2017);
    });
    test("adding 13 months should increase a year and a month", () {
      final startMonth = Month(1, 2018);
      final result = startMonth.add(13);

      expect(result.month, 2);
      expect(result.year, 2019);
    });
    test("subtracting 13 months should decrease a year and a month", () {
      final startMonth = Month(10, 2018);
      final result = startMonth.subtract(13);

      expect(result.month, 9);
      expect(result.year, 2017);
    });
    test("the default string format is \"MMM / yy\"", () {
      final startMonth = Month(10, 2018);

      expect(startMonth.toString(), "OCT / 18");
    });
    test("create using .now() returns current month / year", () {
      final currentMonth = Month.now();

      expect(currentMonth.year, 2018);
      expect(currentMonth.month, 10);
    });

    test("compare 12/2017 to 01/2018 ", () {
      final dec2017 = Month(12, 2017);
      final jan2018 = Month(1, 2018);

      expect(dec2017.compareTo(jan2018), -1);
      expect(jan2018.compareTo(dec2017), 1);
    });

    test("compare 03/2017 to 10/2017 ", () {
      final mar2017 = Month(3, 2017);
      final oct2017 = Month(10, 2017);

      expect(mar2017.compareTo(oct2017), -1);
      expect(oct2017.compareTo(mar2017), 1);
    });
    test("compare 06/2017 to 06/2017 ", () {
      final jun2017 = Month(6, 2017);
      final otherJun2017 = Month(6, 2017);

      expect(jun2017.compareTo(otherJun2017), 0);
      expect(otherJun2017.compareTo(jun2017), 0);
    });
  });
}
