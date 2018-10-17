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
  });
}
