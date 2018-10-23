import "package:intl/intl.dart";
import 'package:money/money.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:app/src/models/serializers.dart';
import 'package:app/src/models/account.dart';
import 'package:app/src/models/category.dart';

part "entry.g.dart";

class EntryType extends EnumClass {
  static Serializer<EntryType> get serializer => _$entryTypeSerializer;
  static const EntryType credit = _$credit;
  static const EntryType debit = _$debit;
  static const EntryType transfer_in = _$transfer_in;

  static const EntryType transfer_out = _$transfer_out;

  const EntryType._(String name) : super(name);

  static BuiltSet<EntryType> get values => _$stValues;
  static EntryType valueOf(String name) => _$stValueOf(name);
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
        decimalDigits: 2, locale: "pt_BR", name: amount.currency.code);

    var result = amount.amount / amount.currency.subUnit;

    if (type == EntryType.debit) return f.format(-result);

    return f.format(result);
  }

  Entry.fromMap(this.id, Map<String, dynamic> data)
      : description = data["description"] ?? "",
        amount = Money.fromDouble(data["amount"] ?? 0.0, Currency("BRL")),
        date = data["date"] ?? DateTime.now(),
        category = serializers.deserializeWith(
            Category.serializer, data["category"] ?? Map()),
        account = serializers.deserializeWith(
            Account.serializer, data["account"] ?? Map()),
        // account = Account.fromMap(data["account"] ?? Map()),
        type = EntryType.valueOf(data["type"] ?? EntryType.debit.toString());

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
}
