import 'package:flutter_test/flutter_test.dart';

import 'package:app/src/screens/routes.dart' as routes;
import 'package:app/src/screens/monthly_expenses.dart';
import 'package:app/src/screens/create_entry.dart';

void main() {
  group("Test routes", () {
    test("homeHandler returns MonthlyExpensesScreen", () {
      final result = routes.homeHandler.handlerFunc(null, null);
      expect(result.runtimeType, MonthlyExpensesScreen);
    });

    test("createEntryHandler returns CreateEntryScreen", () {
      final result = routes.createEntryHandler.handlerFunc(null, null);
      expect(result.runtimeType, CreateEntryScreen);
    });
  });
}
