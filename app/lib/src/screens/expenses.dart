import 'package:flutter/material.dart';
import 'package:app/src/models/entry.dart';
import 'package:app/src/blocs/provider.dart';
import 'package:app/src/blocs/expenses_bloc.dart';
import 'package:app/src/widgets/entry_list.dart';

enum GroupedBy { day, month }

class ExpensesScreen extends StatefulWidget {
  final GroupedBy groupedBy = GroupedBy.month;

  @override
  ExpensesScreenState createState() {
    return new ExpensesScreenState();
  }
}

class ExpensesScreenState extends State<ExpensesScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<ExpensesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Transações"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            color: Colors.white,
            onPressed: null,
          ),
          IconButton(
            icon: Icon(Icons.fiber_new),
            color: Colors.white,
            onPressed: bloc.createEntry,
          ),
        ],
      ),
      body: EntryList(
        entriesListStream: widget.groupedBy == GroupedBy.day
            ? bloc.dailyGroupedEntries
            : bloc.monthlyGroupedEntries,
        onEntryTap: (Entry entry) {
          onEntryTap(context, entry);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.note_add),
        onPressed: () {
          Navigator.of(context).pushNamed("/entry/new");
        },
      ),
    );
  }

  void onEntryTap(BuildContext context, Entry entry) {
    Navigator.of(context).pushNamed("/entry/${entry.id}");
  }
}
