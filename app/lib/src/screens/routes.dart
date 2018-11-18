import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:app/src/blocs/provider.dart';
import 'package:app/src/blocs/monthly_expenses_bloc.dart';
import 'package:app/src/screens/expenses.dart';
import 'package:app/src/screens/create_entry.dart';

var homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return Provider<MonthlyExpensesBloc>(
    child: ExpensesScreen(),
    bloc: MonthlyExpensesBloc(),
  );
});

var createEntryHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return CreateEntryScreen();
});

void setup(Router router) {
  router.notFoundHandler = homeHandler;

  router.define(
    '/',
    handler: homeHandler,
  );

  router.define(
    '/entry/new',
    handler: createEntryHandler,
  );
}
