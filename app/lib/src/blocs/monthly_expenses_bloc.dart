import 'package:app/src/models/month.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/src/models/entry.dart';
import 'package:rxdart/rxdart.dart';

class MonthlyExpensesBloc {
  Stream<List<Entry>> get entries => _getEntries();

  ReplaySubject<Month> _query = ReplaySubject<Month>();
  Function(Month) get changeMonth => _query.sink.add;

  Stream<List<Entry>> _getEntries() {
    return Firestore.instance
        .collection('entries')
        .orderBy("date")
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.documents.map((documentSnapshot) {
        return Entry.fromMap(
            documentSnapshot.documentID, documentSnapshot.data);
      }).toList();
    });
  }

  dispose() {
    _query.close();
  }
}

class MonthlyExpensesProvider extends InheritedWidget {
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  final MonthlyExpensesBloc bloc;

  MonthlyExpensesProvider({Key key, Widget child})
      : bloc = MonthlyExpensesBloc(),
        super(key: key, child: child);

  static MonthlyExpensesBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(MonthlyExpensesProvider)
            as MonthlyExpensesProvider)
        .bloc;
  }
}
