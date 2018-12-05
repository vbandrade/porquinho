import 'package:app/src/blocs/create_entry_bloc.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:app/src/blocs/provider.dart';
import 'package:app/src/blocs/expenses_bloc.dart';
import 'package:app/src/screens/expenses.dart';
import 'package:app/src/screens/create_entry.dart';

var homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return Provider<ExpensesBloc>(
    child: ExpensesScreen(),
    bloc: ExpensesBloc(),
  );
});

var createEntryHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return Provider<EntryBloc>(
    child: CreateEntryScreen(),
    bloc: CreateEntryBloc(),
  );
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
