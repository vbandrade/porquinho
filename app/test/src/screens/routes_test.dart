import 'package:app/src/blocs/monthly_expenses_bloc.dart';
import 'package:app/src/screens/expenses.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/src/blocs/provider.dart';
import 'package:app/src/screens/routes.dart' as routes;
import 'package:app/src/screens/create_entry.dart';

Type _typeOf<T>() => T;

void main() {
  group("Test routes", () {
    ///TODO: Use WidgetTester
    test("homeHandler returns MonthlyExpensesScreen", () {
      Provider result = routes.homeHandler.handlerFunc(null, null);
      final type = _typeOf<Provider<MonthlyExpensesBloc>>();

      expect(result.runtimeType, type);
      expect(result.child.runtimeType, ExpensesScreen);
    });

    test("createEntryHandler returns CreateEntryScreen", () {
      final result = routes.createEntryHandler.handlerFunc(null, null);
      expect(result.runtimeType, CreateEntryScreen);
    });
  });
}
