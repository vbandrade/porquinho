import 'dart:async';
import 'dart:math';
import "package:queries/queries.dart";
import "package:queries/collections.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money/money.dart';
import 'package:app/src/models/account.dart';
import 'package:app/src/models/month.dart';
import 'package:app/src/blocs/entries_mixin.dart';
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/entry_type.dart';

class MonthlyExpensesBloc with EntriesMixin {
  Stream<List<Entry>> get entries => _getEntries();

  Stream<List<MonthlyGroupedEntries>> get groupedEntries =>
      _getMonthlyGroupedEntries();

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
    account["type"] = AccountType.cash.toString();

    Firestore.instance.runTransaction((Transaction transactionHandler) async {
      CollectionReference reference = Firestore.instance.collection("entries");
      await reference.add({
        "type": (r.nextBool() ? EntryType.credit : EntryType.debit).toString(),
        "amount": r.nextDouble() * 100,
        "date": DateTime(
          DateTime.now().year,
          DateTime.now().month,
          r.nextInt(30),
        ),
        "category": cat,
        "description": "lallalalalla",
        "account": account
      });
    });
  }

  Stream<List<Entry>> _getEntries() {
    return Firestore.instance
        .collection("entries")
        .orderBy("date")
        .getDocuments()
        .then((snapshot) {
      return snapshot.documents.map((DocumentSnapshot doc) {
        try {
          return Entry.fromMap(doc.data);
          // return serializers.deserializeWith(Entry.serializer, doc.data);
        } catch (error) {
          print(error);
        }
      }).toList();
    }).asStream();
  }

  Stream<List<MonthlyGroupedEntries>> _getMonthlyGroupedEntries() {
    return _getEntries()
        .map<List<MonthlyGroupedEntries>>((List<Entry> entries) {
      List<IGrouping> dailyIterable = Collection(entries)
          .groupBy<Month>((x) => Month.fromDate(x.date))
          .toList();

      dailyIterable.sort((a, b) => a.key.compareTo(b.key));

      return dailyIterable.map((f) {
        return MonthlyGroupedEntries(f.key, f.toList());
      }).toList();
    });
  }
}

class MonthlyGroupedEntries {
  final Month month;
  final List<Entry> entries;

  MonthlyGroupedEntries(this.month, this.entries);

  Money get totalAmount => entries.fold<Money>(
      Money.fromDouble(0.0, Currency("BRL")), _amountTotalizerCombiner);

  Money _amountTotalizerCombiner(Money previousValue, Entry element) {
    return previousValue + element.sumAmount;
  }
}
