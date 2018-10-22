import 'package:app/src/models/entry.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  final Widget child;

  const Wrapper(this.child);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: child,
      ),
    );
  }
}

class EntriesHelper {
  static Map<String, dynamic> getEntryMap({
    double amount = 3.14,
    EntryType type = EntryType.debit,
  }) {
    Map<String, dynamic> categoryMap = Map<String, dynamic>();
    categoryMap["name"] = "Sports";

    Map<String, dynamic> account = Map<String, dynamic>();
    account["name"] = "cashhh";
    account["type"] = "EntryAccountType.cash";

    return {
      "type": type.toString(),
      "amount": amount,
      "date": DateTime.now(),
      "category": categoryMap,
      "description": "lallalalalla",
      "account": account
    };
  }

  static Entry getDebit(double value) {
    return Entry.fromMap("id1234", getEntryMap(amount: value));
  }

  static Entry getCredit(double value) {
    return Entry.fromMap(
        "id1234", getEntryMap(amount: value, type: EntryType.credit));
  }

  static Entry getTransferIn(double value) {
    return Entry.fromMap(
        "id1234", getEntryMap(amount: value, type: EntryType.transfer_in));
  }

  static Entry getTransferOut(double value) {
    return Entry.fromMap(
        "id1234", getEntryMap(amount: value, type: EntryType.transfer_out));
  }
}
