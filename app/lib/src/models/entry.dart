import "package:intl/intl.dart";
import 'package:app/src/models/account.dart';
import 'package:app/src/models/category.dart';

enum EntryType {
  credit,
  debit,
  transfer_in,
  transfer_out,
}

class Entry {
  String id;
  String description;
  double amount;
  DateTime date;
  Category category;
  EntryType type;
  Account account;

  String get amountString {
    final f = new NumberFormat.simpleCurrency(
        decimalDigits: 2, locale: "pt_BR", name: "BRL");

    if (type == EntryType.debit) return f.format(-amount);
    return f.format(amount);
  }

  Entry.fromMap(this.id, Map<String, dynamic> data)
      : description = data["description"] ?? "",
        amount = data["amount"] ?? 0.0,
        date = data["date"] ?? DateTime.now(),
        category = Category("categoria"),
        account = Account.fromMap(data["account"] ?? Map()),
        type = data["type"] == null
            ? EntryType.debit
            : data["type"].toString().contains("credit")
                ? EntryType.credit
                : EntryType.debit;
}
