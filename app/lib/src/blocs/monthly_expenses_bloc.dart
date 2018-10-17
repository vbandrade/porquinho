import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/src/models/entry.dart';
import 'package:intl/intl.dart';

class MonthlyExpensesBloc {
  Stream<List<Entry>> get entries => _getEntries();

  void changeMonth(Month mont) {}
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

class Month {
  final int month;
  final int year;
  DateFormat formater = DateFormat("MMM / yy");

  Month(this.month, this.year);

  Month add(int months) {
    DateTime result = DateTime(year, month + months);
    return Month(result.month, result.year);
  }

  Month subtract(int months) {
    DateTime result = DateTime(year, month - months);
    return Month(result.month, result.year);
  }

  @override
  String toString() {
    return formater.format(DateTime(year, month)).toUpperCase();
  }
}
