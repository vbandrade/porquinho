import 'package:app/src/models/month.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/src/models/entry.dart';
import 'package:rxdart/rxdart.dart';

class MonthlyExpensesBloc {
  ReplaySubject<Month> _query = ReplaySubject<Month>();
  Function(Month) get changeMonth => _query.sink.add;

  Stream<List<Entry>> _results = Stream.empty();
  Stream<List<Entry>> get entries => _results;

  MonthlyExpensesBloc() {
    _results = _query
        .debounce(Duration(milliseconds: 200))
        .asyncMap(_getEntriesByMonth)
        .asBroadcastStream();

    _query.add(Month.now());
  }

  Future<List<Entry>> _getEntriesByMonth(Month month) {
    DateTime dtStart = DateTime(month.year, month.month, 1, 0, 0);
    DateTime dtEnd = DateTime(month.year, month.month + 1, 0, 23, 59, 59, 999);

    return Firestore.instance
        .collection("entries")
        .where("date", isGreaterThanOrEqualTo: dtStart)
        .where("date", isLessThanOrEqualTo: dtEnd)
        .getDocuments()
        .then((snapshot) {
      return snapshot.documents.map((DocumentSnapshot doc) {
        return Entry.fromMap(doc.documentID, doc.data);
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
