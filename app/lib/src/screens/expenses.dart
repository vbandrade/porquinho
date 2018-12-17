import 'package:flutter/material.dart';
import 'package:app/src/models/entry.dart';
import 'package:app/src/blocs/provider.dart';
import 'package:app/src/blocs/expenses_bloc.dart';
import 'package:app/src/widgets/entry_list.dart';

class ExpensesScreen extends StatelessWidget {
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
        entriesListStream: bloc.groupedEntries,
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
