import "package:intl/intl.dart";
import 'package:money/money.dart';
import 'package:app/src/models/account.dart';
import 'package:app/src/models/category.dart';

enum EntryType {
  credit,
  debit,
  transfer_in,
  transfer_out,
}

class Entry {
  final String id;
  final String description;
  final Money amount;
  final DateTime date;
  final Category category;
  final EntryType type;
  final Account account;

  String get amountString {
    final f = new NumberFormat.simpleCurrency(
        decimalDigits: 2, locale: "pt_BR", name: "BRL");

    var result = amount.amount / amount.currency.subUnit;

    if (type == EntryType.debit) return f.format(-result);

    return f.format(result);
  }

  Entry.fromMap(this.id, Map<String, dynamic> data)
      : description = data["description"] ?? "",
        amount = Money.fromDouble(data["amount"] ?? 0.0, Currency("BRL")),
        date = data["date"] ?? DateTime.now(),
        category = Category("categoria"),
        account = Account.fromMap(data["account"] ?? Map()),
        type = data["type"] == null
            ? EntryType.debit
            : data["type"].toString().contains("credit")
                ? EntryType.credit
                : EntryType.debit;
}
