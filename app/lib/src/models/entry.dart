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
}
