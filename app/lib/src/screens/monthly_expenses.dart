import 'package:app/src/widgets/navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:app/src/widgets/entry_list.dart';
import 'package:app/src/blocs/monthly_expenses_bloc.dart';

class MonthlyExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = MonthlyExpensesProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: Text("Transações")),
      body: Column(
        children: <Widget>[
          NavigationBar(bloc.changeMonth),
          Expanded(child: EntryList(bloc.entries)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add),
        onPressed: () {
          Navigator.of(context).pushNamed("/entry/new");
        },
      ),
    );
  }
}
