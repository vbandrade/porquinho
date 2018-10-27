import 'dart:async';
import 'dart:math';
import 'package:money/money.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/src/blocs/entries_mixin.dart';
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/month.dart';

class MonthlyExpensesBloc with EntriesMixin {
  final _query = ReplaySubject<Month>();
  Function(Month) get changeMonth => _query.sink.add;

  Stream<List<Entry>> _results;
  Stream<List<Entry>> get entries => _results;

  final _itemsOutput =
      BehaviorSubject<Money>(seedValue: Money.fromDouble(0.0, Currency("BRL")));
  Stream<Money> get totalAmount => _itemsOutput.stream;

  Month _currentMonth;

  MonthlyExpensesBloc() {
    _results = _query
        .debounce(Duration(milliseconds: 200))
        .asyncMap(_getEntriesByMonth)
        .asBroadcastStream();

    _results.transform(amountTotalizerTransformer).pipe(_itemsOutput);

    _query.add(Month.now());
  }

  Future<List<Entry>> _getEntriesByMonth(Month month) {
    _currentMonth = month;
    DateTime dtStart = DateTime(month.year, month.month, 1, 0, 0);
    DateTime dtEnd = DateTime(month.year, month.month + 1, 0, 23, 59, 59, 999);

    return Firestore.instance
        .collection("entries")
        .where("date", isGreaterThanOrEqualTo: dtStart)
        .where("date", isLessThanOrEqualTo: dtEnd)
        .getDocuments()
        .then((snapshot) {
      return snapshot.documents.map((DocumentSnapshot doc) {
        try {
          return Entry.fromMap(doc.documentID, doc.data);
        } catch (error) {
          print(error);
        }
      }).toList();
    });
  }

  void _deleteEntry(String id) {
    Firestore.instance.runTransaction((transaction) async {
      DocumentReference docReference =
          Firestore.instance.document("entries/$id");
      docReference.delete().whenComplete(() {
        print("Deleted Successfully");
      }).catchError((e) => print(e));
    });
  }

  void createEntry() {
    print("FirestoreEntryRepository.createEntry");
    Random r = new Random();

    List<String> categories = [
      "farmacia",
      "random",
      "mergulho",
      "academia",
      "taxi"
    ];
    Map<String, dynamic> cat = Map<String, dynamic>();
    cat["name"] = categories[r.nextInt(categories.length)];

    Map<String, dynamic> account = Map<String, dynamic>();
    account["name"] = "cashhh";
    account["type"] = "EntryAccountType.cash";

    Firestore.instance.runTransaction((Transaction transactionHandler) async {
      CollectionReference reference = Firestore.instance.collection("entries");
      await reference.add({
        "type": (r.nextBool() ? EntryType.credit : EntryType.debit).toString(),
        "amount": r.nextDouble() * 100,
        "date": new DateTime(
            _currentMonth.year, _currentMonth.month, r.nextInt(30)),
        "category": cat,
        "description": "lallalalalla",
        "account": account
      });
    });
  }

  dispose() {
    _query.close();
    _itemsOutput.close();
  }
}
