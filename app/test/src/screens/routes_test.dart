import 'package:app/src/blocs/monthly_expenses_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/src/screens/routes.dart' as routes;
import 'package:app/src/screens/monthly_expenses.dart';
import 'package:app/src/screens/create_entry.dart';

void main() {
  group("Test routes", () {
    ///TODO: Use WidgetTester
    test("homeHandler returns MonthlyExpensesScreen", () {
      MonthlyExpensesProvider result =
          routes.homeHandler.handlerFunc(null, null);

      expect(result.runtimeType, MonthlyExpensesProvider);
      expect(result.child.runtimeType, MonthlyExpensesScreen);
    });

    test("createEntryHandler returns CreateEntryScreen", () {
      final result = routes.createEntryHandler.handlerFunc(null, null);
      expect(result.runtimeType, CreateEntryScreen);
    });
  });
}
