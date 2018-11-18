import 'dart:async';
import 'dart:math';
import 'package:app/src/models/account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app/src/blocs/entries_mixin.dart';
import 'package:app/src/models/entry.dart';

class MonthlyExpensesBloc with EntriesMixin {
  Stream<List<Entry>> get entries => _getEntries();

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
          return Entry.fromMap(doc.documentID, doc.data);
        } catch (error) {
          print(error);
        }
      }).toList();
    }).asStream();
  }
}
