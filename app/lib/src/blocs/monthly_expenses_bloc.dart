import 'dart:async';
import 'package:money/money.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/month.dart';

class MonthlyExpensesBloc extends Object with EntriesMixin {
  final _query = ReplaySubject<Month>();
  Function(Month) get changeMonth => _query.sink.add;

  Stream<List<Entry>> _results;
  Stream<List<Entry>> get entries => _results;

  final _itemsOutput = BehaviorSubject<Money>();
  Stream<Money> get totalAmount => _itemsOutput.stream;

  MonthlyExpensesBloc() {
    _results = _query
        .debounce(Duration(milliseconds: 200))
        .asyncMap(_getEntriesByMonth)
        .asBroadcastStream();

    _results.transform(amountTotalizerTransformer).pipe(_itemsOutput);

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
    _itemsOutput.close();
  }
}

class EntriesMixin {
  StreamTransformer<List<Entry>, Money> get amountTotalizerTransformer =>
      _amountTotalizerTransformer();

  StreamTransformer<List<Entry>, Money> _amountTotalizerTransformer() {
    var initialValue = Money.fromDouble(0.0, Currency("BRL"));
    return ScanStreamTransformer((Money acc, List<Entry> curr, int i) {
      return curr.fold<Money>(initialValue, _amountTotalizerCombiner);
    });
  }

  Money _amountTotalizerCombiner(Money previousValue, Entry element) {
    return previousValue + element.sumAmount;
  }
}
