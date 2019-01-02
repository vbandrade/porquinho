import 'package:built_value/serializer.dart';
import "package:built_value/standard_json_plugin.dart";
import 'package:app/src/models/entry.dart';
import 'package:app/src/models/entry_type.dart';
import 'package:app/src/models/account.dart';
import 'package:app/src/models/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money/money.dart';

part "serializers.g.dart";

@SerializersFor(
    const [Category, Account, AccountType, Entry, EntryType, Money, Currency])
final Serializers serializers = (_$serializers.toBuilder()
      ..addPlugin(StandardJsonPlugin())
      ..addPlugin(DateTimeToTimestampSerializerPlugin()))
    .build();

class DateTimeToTimestampSerializerPlugin implements SerializerPlugin {
  @override
  Object beforeSerialize(Object object, FullType specifiedType) {
    return object;
  }

  @override
  Object afterSerialize(Object object, FullType specifiedType) {
    if (object is int && specifiedType.root == DateTime)
      return Timestamp.fromMicrosecondsSinceEpoch(object);

    return object;
  }

  @override
  Object beforeDeserialize(Object object, FullType specifiedType) {
    if (object is Timestamp && specifiedType.root == DateTime)
      return object.microsecondsSinceEpoch;

    return object;
  }

  @override
  Object afterDeserialize(Object object, FullType specifiedType) {
    return object;
  }
}
