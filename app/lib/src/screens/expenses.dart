import 'package:flutter/material.dart';
import 'package:app/src/models/entry.dart';
import 'package:app/src/blocs/provider.dart';
import 'package:app/src/blocs/expenses_bloc.dart';
import 'package:app/src/screens/routes.dart';
import 'package:app/src/widgets/left_drawer.dart';
import 'package:app/src/widgets/entry_list.dart';

enum GroupedBy { day, month }

class ExpensesScreen extends StatefulWidget {
  @override
  ExpensesScreenState createState() {
    return new ExpensesScreenState();
  }
}

class ExpensesScreenState extends State<ExpensesScreen> {
  GroupedBy _groupedBy = GroupedBy.month;

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
          IconButton(
            icon: Icon(Icons.calendar_today),
            color: Colors.white,
            onPressed: () {
              setState(() {
                if (_groupedBy == GroupedBy.day)
                  _groupedBy = GroupedBy.month;
                else
                  _groupedBy = GroupedBy.day;
              });
            },
          ),
        ],
      ),
      drawer: SideDrawer(Screens.expense_list),
      body: EntryList(
        entriesListStream: _groupedBy == GroupedBy.day
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
