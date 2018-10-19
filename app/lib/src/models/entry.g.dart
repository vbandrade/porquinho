// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

const EntryType _$credit = const EntryType._('credit');
const EntryType _$debit = const EntryType._('debit');
const EntryType _$transfer_in = const EntryType._('transfer_in');
const EntryType _$transfer_out = const EntryType._('transfer_out');

EntryType _$stValueOf(String name) {
  switch (name) {
    case 'credit':
      return _$credit;
    case 'debit':
      return _$debit;
    case 'transfer_in':
      return _$transfer_in;
    case 'transfer_out':
      return _$transfer_out;
    default:
      throw new ArgumentError(name);
  }
}

final BuiltSet<EntryType> _$stValues =
    new BuiltSet<EntryType>(const <EntryType>[
  _$credit,
  _$debit,
  _$transfer_in,
  _$transfer_out,
]);

Serializer<EntryType> _$entryTypeSerializer = new _$EntryTypeSerializer();

class _$EntryTypeSerializer implements PrimitiveSerializer<EntryType> {
  @override
  final Iterable<Type> types = const <Type>[EntryType];
  @override
  final String wireName = 'EntryType';

  @override
  Object serialize(Serializers serializers, EntryType object,
          {FullType specifiedType = FullType.unspecified}) =>
      object.name;

  @override
  EntryType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      EntryType.valueOf(serialized as String);
}
