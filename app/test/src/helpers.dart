import 'dart:math';

import 'package:app/src/models/account.dart';
import 'package:app/src/models/category.dart';
import 'package:flutter/material.dart';
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/entry_type.dart';
import 'package:money/money.dart';

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
    account["id"] = "1223";
    account["name"] = "cashhh";
    account["type"] = "cash";

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
    return _getEntry(amount: value, type: EntryType.debit);
  }

  static Entry getCredit(double value) {
    return _getEntry(amount: value, type: EntryType.credit);
  }

  static Entry getTransferIn(double value) {
    return _getEntry(amount: value, type: EntryType.transfer_in);
  }

  static Entry getTransferOut(double value) {
    return _getEntry(amount: value, type: EntryType.transfer_out);
  }

  static Entry _getEntry({
    double amount = 3.14,
    EntryType type: EntryType.debit,
  }) {
    Random r = new Random();

    List<String> categories = [
      "farmacia",
      "random",
      "mergulho",
      "academia",
      "taxi"
    ];

    final catBuilder = CategoryBuilder()
      ..name = categories[r.nextInt(categories.length)];

    final accBuilder = AccountBuilder()
      ..type = AccountType.cash
      ..name = "cha ching!";

    final builder = EntryBuilder()
      ..description = "from built_value \\o/"
      ..amount = Money.fromInt((amount * 100).toInt(), Currency.fromCode("BRL"))
          .toBuilder()
      ..date = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        r.nextInt(30),
        12,
      ).toUtc()
      ..type = type
      ..category = catBuilder
      ..account = accBuilder;

    return builder.build();
  }
}
