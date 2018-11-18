import 'package:flutter/material.dart';
import 'package:app/src/blocs/provider.dart';
import 'package:app/src/blocs/monthly_expenses_bloc.dart';
import 'package:app/src/widgets/entry_list.dart';

class ExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<MonthlyExpensesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Transações"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.fiber_new),
            color: Colors.white,
            onPressed: bloc.createEntry,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(bottom: 8.0)),
          Expanded(
            child: EntryList(bloc.entries),
          ),
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
