import 'package:flutter_test/flutter_test.dart';
import 'package:app/src/blocs/provider.dart';
import 'package:app/src/screens/routes.dart' as routes;
import 'package:app/src/screens/monthly_expenses.dart';
import 'package:app/src/screens/create_entry.dart';

void main() {
  group("Test routes", () {
    ///TODO: Use WidgetTester
    test("homeHandler returns MonthlyExpensesScreen", () {
      Provider result = routes.homeHandler.handlerFunc(null, null);

      expect(result.runtimeType.toString(), "Provider<MonthlyExpensesBloc>");
      expect(result.child.runtimeType, MonthlyExpensesScreen);
    });

    test("createEntryHandler returns CreateEntryScreen", () {
      final result = routes.createEntryHandler.handlerFunc(null, null);
      expect(result.runtimeType, CreateEntryScreen);
    });
  });
}
