import "package:intl/intl.dart";
import 'package:money/money.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:app/src/models/account.dart';
import 'package:app/src/models/category.dart';
import 'package:app/src/models/entry_type.dart';

part 'entry.g.dart';

abstract class Entry implements Built<Entry, EntryBuilder> {
  @nullable
  String get id;
  String get description;
  Money get amount;
  DateTime get date;
  Category get category;
  EntryType get type;
  Account get account;

  String get amountString {
    final f = new NumberFormat.simpleCurrency(
        decimalDigits: 2, locale: "pt_BR", name: amount.currency.code);

    var result = amount.amount / amount.currency.subUnit;

    if (type == EntryType.debit) return f.format(-result);

    return f.format(result);
  }

  Entry._();
  factory Entry([updates(EntryBuilder b)]) = _$Entry;

  static Serializer<Entry> get serializer => _$entrySerializer;

  Money get sumAmount {
    switch (type) {
      case EntryType.credit:
      case EntryType.transfer_in:
        return amount;
        break;
      case EntryType.debit:
      case EntryType.transfer_out:
        return -amount;
        break;
      default:
        return amount;
    }
  }

  // static Entry fromMap(Map<String, dynamic> data) {
  //   final catBuilder = CategoryBuilder()..name = "new category";
  //   final accBuilder = AccountBuilder()
  //     ..id = "112"
  //     ..type = AccountType.checking
  //     ..name = "new account";

  //   final moneyBuilder = MoneyBuilder()
  //     ..amount = data["amount"]
  //     ..currency = Currency.fromCode("BRL").toBuilder();

  //   final builder = EntryBuilder()
  //     ..id = data["id"] ?? ""
  //     ..description = data["description"] ?? ""
  //     ..amount = moneyBuilder
  //     ..date = (data["date"] as DateTime).toUtc()
  //     ..type = EntryType.valueOf(data["type"] ?? EntryType.debit.toString())
  //     ..category = catBuilder
  //     ..account = accBuilder;

  //   return builder.build();
  // }
}
