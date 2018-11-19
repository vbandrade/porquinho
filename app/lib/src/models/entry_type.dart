import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part "entry_type.g.dart";

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
