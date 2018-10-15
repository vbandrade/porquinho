import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'package:app/src/screens/monthly_expenses.dart';
import 'package:app/src/screens/create_entry.dart';

var homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return MonthlyExpensesScreen();
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
