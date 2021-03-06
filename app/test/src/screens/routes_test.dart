import 'package:app/src/blocs/create_entry_bloc.dart';
import 'package:app/src/blocs/expenses_bloc.dart';
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
      final type = _typeOf<Provider<ExpensesBloc>>();

      expect(result.runtimeType, type);
      expect(result.child.runtimeType, ExpensesScreen);
    });

    test("createEntryHandler returns CreateEntryScreen", () {
      Provider result = routes.createEntryHandler.handlerFunc(null, null);
      final type = _typeOf<Provider<EntryBloc>>();

      expect(result.runtimeType, type);
      expect(result.child.runtimeType, CreateEntryScreen);

      // final result = routes.createEntryHandler.handlerFunc(null, null);
      // expect(result.runtimeType, CreateEntryScreen);
    });
  });
}
