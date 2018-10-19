import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/src/models/month.dart';
import 'package:app/src/widgets/navigation_bar.dart';
import '../helpers.dart';

void main() {
  group('NavigationBar ', () {
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
        find.widgetWithText(FlatButton, "< $previousMonth"),
        findsOneWidget,
      );

      expect(
        find.widgetWithText(FlatButton, "$nextMonth >"),
        findsOneWidget,
      );
    });

    testWidgets('Tap no botado mes anterior muda o texto exibido',
        (WidgetTester tester) async {
      Month result;

      final previousMonth = Month.now().subtract(1);

      Function(Month) _onMonthChanged = (month) {
        result = month;
      };

      await tester.pumpWidget(Wrapper(NavigationBar(_onMonthChanged)));

      await tester.tap(find.widgetWithText(FlatButton, "< $previousMonth"));

      await tester.pumpAndSettle();

      expect(
        find.text("$previousMonth"),
        findsOneWidget,
      );
      expect(result.toString(), previousMonth.toString());
    });

    testWidgets('Tap no botado proximo mes muda o texto exibido',
        (WidgetTester tester) async {
      Month result;

      final nextMonth = Month.now().add(1);

      Function(Month) _onMonthChanged = (month) {
        result = month;
      };

      await tester.pumpWidget(Wrapper(NavigationBar(_onMonthChanged)));

      await tester.tap(find.widgetWithText(FlatButton, "$nextMonth >"));

      await tester.pumpAndSettle();
      expect(
        find.text("$nextMonth"),
        findsOneWidget,
      );
      expect(result.toString(), nextMonth.toString());
    });
  });
}
