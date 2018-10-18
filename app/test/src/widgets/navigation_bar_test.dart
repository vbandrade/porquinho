import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/src/models/month.dart';
import 'package:app/src/widgets/navigation_bar.dart';
import '../helpers.dart';

void main() {
  group('NavigationBar ', () {
    testWidgets('NavigationBar criado no mes/ano atual',
        (WidgetTester tester) async {
      await tester.pumpWidget(Wrapper(NavigationBar(null)));

      final currentMonth = Month.now();
      expect(find.text(currentMonth.toString()), findsOneWidget);
    });

    testWidgets('NavigationBar criado no mes/ano atual, exibe meses corretos',
        (WidgetTester tester) async {
      await tester.pumpWidget(Wrapper(NavigationBar(null)));

      final currentMonth = Month.now();
      final previousMonth = currentMonth.subtract(1);
      final nextMonth = currentMonth.add(1);

      expect(
        find.text("$currentMonth"),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(FlatButton, "$nextMonth >"),
        findsOneWidget,
      );
      expect(
        find.widgetWithText(FlatButton, "< $previousMonth"),
        findsOneWidget,
      );
    });

    Function(Month) _onMonthChanged = (month) {};
    testWidgets('Tap no botado mes anterior muda o texto exibido',
        (WidgetTester tester) async {
      await tester.pumpWidget(Wrapper(NavigationBar(_onMonthChanged)));

      final previousMonth = Month.now().subtract(1);

      await tester.tap(find.widgetWithText(FlatButton, "< $previousMonth"));

      await tester.pumpAndSettle();
      expect(
        find.text("$previousMonth"),
        findsOneWidget,
      );
    });

    testWidgets('Tap no botado proximos mes muda o texto exibido',
        (WidgetTester tester) async {
      await tester.pumpWidget(Wrapper(NavigationBar(_onMonthChanged)));

      final nextMonth = Month.now().add(1);

      await tester.tap(find.widgetWithText(FlatButton, "$nextMonth >"));

      await tester.pumpAndSettle();
      expect(
        find.text("$nextMonth"),
        findsOneWidget,
      );
    });
  });
}
